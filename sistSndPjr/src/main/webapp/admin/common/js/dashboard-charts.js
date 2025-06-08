/*import { Chart } from "@/components/ui/chart"*/
// 대시보드 차트 초기화 및 관리
// 전역 변수들은 JSP에서 정의됨

function initializeCharts() {
  console.log("=== initializeCharts 함수 시작 ===")

  // JSP에서 전달받은 데이터 확인
  if (typeof window.membershipData === "undefined") {
    console.error("window.membershipData가 정의되지 않았습니다.")
    return
  }

  if (typeof window.reviewData === "undefined") {
    console.error("window.reviewData가 정의되지 않았습니다.")
    return
  }

  console.log("membershipData:", window.membershipData)
  console.log("reviewData:", window.reviewData)

  // 회원가입 차트 초기화
  const membershipCtx = document.getElementById("membershipChart")
  if (membershipCtx) {
    // 기존 차트가 있다면 제거 (존재 여부 확인)
    if (window.membershipChart && typeof window.membershipChart.destroy === "function") {
      window.membershipChart.destroy()
    }

    if (window.membershipData.labels.length > 0 && window.membershipData.labels[0] !== "데이터 없음") {
      window.membershipChart = new Chart(membershipCtx, {
        type: "line",
        data: {
          labels: window.membershipData.labels,
          datasets: [
            {
              label: "가입자 수",
              data: window.membershipData.data,
              borderColor: "#3b82f6",
              backgroundColor: "rgba(59, 130, 246, 0.1)",
              fill: true,
              tension: 0.4,
              pointBackgroundColor: "#3b82f6",
              pointBorderColor: "#ffffff",
              pointBorderWidth: 2,
              pointRadius: 4,
              pointHoverRadius: 6,
            },
          ],
        },
        options: {
          responsive: true,
          maintainAspectRatio: false,
          plugins: {
            legend: {
              display: false,
            },
            tooltip: {
              backgroundColor: "rgba(0, 0, 0, 0.8)",
              titleColor: "#ffffff",
              bodyColor: "#ffffff",
              borderColor: "#3b82f6",
              borderWidth: 1,
              callbacks: {
                label: (context) => "가입자: " + context.parsed.y + "명",
              },
            },
          },
          scales: {
            y: {
              beginAtZero: true,
              grid: {
                color: "#f3f4f6",
                drawBorder: false,
              },
              ticks: {
                color: "#6b7280",
                font: {
                  size: 12,
                },
                stepSize: 1,
              },
            },
            x: {
              grid: {
                display: false,
              },
              ticks: {
                color: "#6b7280",
                font: {
                  size: 12,
                },
                maxRotation: 45,
              },
            },
          },
          interaction: {
            intersect: false,
            mode: "index",
          },
        },
      })
      console.log("회원가입 차트 생성 완료")
    } else {
      // 데이터가 없을 때 메시지 표시
      showNoDataMessage(membershipCtx, "회원가입 데이터가 없습니다")
    }
  }

  // 리뷰 차트 초기화
  const reviewCtx = document.getElementById("reviewChart")
  if (reviewCtx) {
    // 기존 차트가 있다면 제거 (존재 여부 확인)
    if (window.reviewChart && typeof window.reviewChart.destroy === "function") {
      window.reviewChart.destroy()
    }

    if (window.reviewData.labels.length > 0 && window.reviewData.labels[0] !== "데이터 없음") {
      window.reviewChart = new Chart(reviewCtx, {
        type: "line",
        data: {
          labels: window.reviewData.labels,
          datasets: [
            {
              label: "리뷰 수",
              data: window.reviewData.data,
              borderColor: "#10b981",
              backgroundColor: "rgba(16, 185, 129, 0.1)",
              fill: true,
              tension: 0.4,
              pointBackgroundColor: "#10b981",
              pointBorderColor: "#ffffff",
              pointBorderWidth: 2,
              pointRadius: 4,
              pointHoverRadius: 6,
            },
          ],
        },
        options: {
          responsive: true,
          maintainAspectRatio: false,
          plugins: {
            legend: {
              display: false,
            },
            tooltip: {
              backgroundColor: "rgba(0, 0, 0, 0.8)",
              titleColor: "#ffffff",
              bodyColor: "#ffffff",
              borderColor: "#10b981",
              borderWidth: 1,
              callbacks: {
                label: (context) => "리뷰: " + context.parsed.y + "개",
              },
            },
          },
          scales: {
            y: {
              beginAtZero: true,
              grid: {
                color: "#f3f4f6",
                drawBorder: false,
              },
              ticks: {
                color: "#6b7280",
                font: {
                  size: 12,
                },
                stepSize: 1,
              },
            },
            x: {
              grid: {
                display: false,
              },
              ticks: {
                color: "#6b7280",
                font: {
                  size: 12,
                },
                maxRotation: 45,
              },
            },
          },
          interaction: {
            intersect: false,
            mode: "index",
          },
        },
      })
      console.log("리뷰 차트 생성 완료")
    } else {
      // 데이터가 없을 때 메시지 표시
      showNoDataMessage(reviewCtx, "리뷰 데이터가 없습니다")
    }
  }
}

// 데이터가 없을 때 메시지 표시 함수
function showNoDataMessage(canvas, message) {
  const ctx = canvas.getContext("2d")
  ctx.clearRect(0, 0, canvas.width, canvas.height)
  ctx.font = "16px Arial"
  ctx.fillStyle = "#6b7280"
  ctx.textAlign = "center"
  ctx.textBaseline = "middle"
  ctx.fillText(message, canvas.width / 2, canvas.height / 2)
}

// 데이터 검증 함수
function validateChartData() {
  console.log("=== 차트 데이터 검증 ===")

  if (typeof window.membershipData === "undefined") {
    console.error("membershipData가 정의되지 않았습니다.")
    return false
  }

  if (typeof window.reviewData === "undefined") {
    console.error("reviewData가 정의되지 않았습니다.")
    return false
  }

  console.log("membershipData:", window.membershipData)
  console.log("reviewData:", window.reviewData)

  if (window.membershipData.labels.length === 0 || window.membershipData.labels[0] === "데이터 없음") {
    console.warn("회원가입 데이터가 비어있습니다.")
  }

  if (window.reviewData.labels.length === 0 || window.reviewData.labels[0] === "데이터 없음") {
    console.warn("리뷰 데이터가 비어있습니다.")
  }

  return true
}

// 통계 카드 애니메이션
function animateCounters() {
  const counters = document.querySelectorAll(".stats-value")

  counters.forEach((counter) => {
    const target = Number.parseInt(counter.textContent.replace(/,/g, ""))
    if (isNaN(target)) return

    const increment = target / 100
    let current = 0

    const timer = setInterval(() => {
      current += increment
      if (current >= target) {
        counter.textContent = target.toLocaleString()
        clearInterval(timer)
      } else {
        counter.textContent = Math.floor(current).toLocaleString()
      }
    }, 20)
  })
}

// 차트 새로고침 함수
function refreshCharts() {
  console.log("=== 차트 새로고침 ===")

  // 기존 차트 제거
  if (window.membershipChart && typeof window.membershipChart.destroy === "function") {
    window.membershipChart.destroy()
    window.membershipChart = null
  }

  if (window.reviewChart && typeof window.reviewChart.destroy === "function") {
    window.reviewChart.destroy()
    window.reviewChart = null
  }

  // 차트 재생성
  initializeCharts()
}

// 차트 초기화를 위한 메인 함수
function initDashboard() {
  console.log("=== 대시보드 초기화 시작 ===")

  // Chart.js 로드 확인
  if (typeof Chart === "undefined") {
    console.error("Chart.js가 로드되지 않았습니다.")
    setTimeout(initDashboard, 100) // 100ms 후 재시도
    return
  }

  // 데이터 검증
  if (!validateChartData()) {
    console.error("차트 데이터 검증 실패")
    return
  }

  // 차트 초기화
  initializeCharts()

  // 카운터 애니메이션 실행
  setTimeout(() => {
    animateCounters()
  }, 500)
}

// 페이지 로드 완료 후 실행
if (document.readyState === "loading") {
  document.addEventListener("DOMContentLoaded", () => {
    setTimeout(initDashboard, 200) // JSP 데이터 로드 대기
  })
} else {
  setTimeout(initDashboard, 200)
}

// 전역 함수로 노출 (필요시 외부에서 호출 가능)
window.refreshDashboard = refreshCharts
