Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E690634DB6D;
	Mon, 24 Aug 2026 01:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787535482; cv=none; b=Pxp+905NsE+EHED31U88FjzAadb9jNsp7VKoaz8y6yaTXrY1E1qz6QyCi5/Hb8uP1IYMdKlOFgIK0m0I+i52cSGFdHIjmCiEXhk3Hhfjgd0xBJBDgomoCmww0Ni9fnSa0s8ry/xlGa1a8fBBHNlnZGqAU28xj41NolXlV78N9YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787535482; c=relaxed/simple;
	bh=iIn331vZGhp0oq0o4IDXFMzEWNmGmWO7Ouj7xJUPEEE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iUWs2o4cq780bLNwLn9dTwQ0scM08UO6bwKTI4LAWf/E1198NTD/blnSVlNNbv1rKRsS5J0OXm6XCjMPdwkPlJJ2tooz1qWBi2X9RQ9GoC/KSFFHjIm/IuLELSnB0iRJASTx7HTKWxYNTnnapluvw8HET9YSk+0/qvwCc5EbcnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TNm6vEGB; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TNm6vEGB"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67O00bxs1183841;
	Mon, 24 Aug 2026 01:32:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=RpxbZ4LtKILLb//aNCTO9zDz+vrjz
	qBW0Q/7SWfGCE8=; b=TNm6vEGBs80Yzu/sLCMHWJCR6Osie0fRBF5F/lTKnHk9F
	ALRQqYEFiFl32tLdSyeqXlRJxxLo7hrACwTi0xEzYGRSXVwkBlGyasvzZpCoeNaM
	wmD9vEjZfYhbPiSifXxCHTBBKHUmgo/zc3qmOTfPelglfySxleLKlq8MfANVul4z
	+hu2LgPuNe+cKEQM9tcpSTU/qaSK7k/JEh8/vlwv7Jd4dFkmt0k63TonPn/Agv4K
	S4RPd3jNXAgdEZW2FiSejYCNNsK2Tg7sysx7w2gRGcOwDDjX5Fyr1ML9mPVTvT53
	6ruVS3mrGkRKxNOFRspQpLNRbQIFCGB2EgSSe6TJg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4g73tchd8r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 01:32:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67O1PSwd036746;
	Mon, 24 Aug 2026 01:32:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4g84kh750g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 01:32:42 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 67O1Wgn1010282;
	Mon, 24 Aug 2026 01:32:42 GMT
Received: from localhost.localdomain (ca-dev80.us.oracle.com [10.211.9.80])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4g84kh7504-1;
	Mon, 24 Aug 2026 01:32:41 +0000 (GMT)
From: Dongli Zhang <dongli.zhang@oracle.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: seanjc@google.com, pbonzini@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com,
        dwmw2@infradead.org, joe.jin@oracle.com
Subject: [PATCH RFC 0/2] Fix KVM guest scheduling accounting issue related to stealtime
Date: Sun, 23 Aug 2026 18:26:24 -0700
Message-ID: <20260824012716.753022-1-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_01,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2608240010
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDAxMiBTYWx0ZWRfXzsfMeyQ66+gA
 0drOYdNFmymqmW+7zEIHXOrdVCwHxjI2B9Vp6oXlLOZnVouq5z35hirCicL4a3UDnWBptpBXI5B
 xIkPwkScEDC/Ayex84KZN3YOom7KlMPP+ijXQftm3m04CGyw9b+G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDAxMiBTYWx0ZWRfX4nzUHEw/3b8n
 YynG4s5XOuyR3Lfg/vgoIFYOFjTP9ivcD/cxOLNl0fM74G+odQjP5CEJPST1gS81VqkO2PMK/l3
 eMENwVJh41KwTOr3pWpaUsxgweIRulL4fbBcj033X2XD/UsjzIhcElp0AGmCpRhXKAw7T7NZUo3
 bOhWNFZupDLGertkzhyCn+rgVwLrrbkpAEEvbG0aGZenUV3JTirdoyuzi2o2rW6y+8lnUG131J9
 oNNSuR09SV7PUDndeiIF1ohceTdw9YScWuvH5T+H0Rlh/1Xf3hOv5aO3l/Fwo8WBAznyDzwCpau
 QxG7i9gBEXpxQgPETOXDUQAO3wcImcpI/GDspmFe2gl8DbknJWXu6PITOBYbaPKqzJpPDlEEMyB
 dIaRQh3LFtWVzaQIAP2uCYsOcbUG2+In0ncTeHo2eSUrxGfC+k6ztz1znoNO7dr+n/btKa61TDF
 H0DNzFKkzQvK6Jt6y6nNUNxYXpm+LzzxmUsfjV4k=
X-Proofpoint-GUID: uOFZl3hrBVsS4pN61HRU0M00UbYcknpg
X-Proofpoint-ORIG-GUID: uOFZl3hrBVsS4pN61HRU0M00UbYcknpg
X-Authority-Analysis: v=2.4 cv=bq98wkai c=1 sm=1 tr=0 ts=6a8b9f3b b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=bTynLD9VKXrF6WClF6AA:9 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13521

This RFC fixes a KVM guest scheduling accounting issue.

The Linux scheduler may allow one CPU to perform accounting for another CPU
through update_rq_clock_task(). This works well on baremetal.

However, in a KVM guest, stealtime may not be accounted for and deducted
from runtime correctly.

Suppose vCPU A performs accounting for vCPU B, while vCPU B is preempted
and stalled by the KVM host for 10 seconds. Unfortunately, the KVM host
does not update stealtime until vCPU B is about to re-enter the guest. As a
result, vCPU A cannot observe the increase in vCPU B's stealtime.

Consequently, the guest kernel incorrectly considers a task running on
vCPU B during the stall to have exclusively used the vCPU for an extended
period. The task may therefore incur an additional scheduling penalty.

Later, when stealtime is updated, it may exceed the elapsed runtime delta,
preventing all of the stealtime from being deducted.

To fix this issue, update KVM stealtime before clearing the vCPU's
preempted state. In the guest scheduler, use vcpu_is_preempted() to help
defer clock_task updates performed by a remote CPU while the owning vCPU is
reported as preempted.


To reproduce, first configure KVM host pCPU 10 so that a vCPU thread pinned to
it can be stalled.

hv# echo -1 | sudo tee /proc/sys/kernel/sched_rt_runtime_us

hv# echo 0 | sudo tee /sys/kernel/debug/sched/fair_server/cpu10/runtime

hv# cat /sys/kernel/debug/sched/fair_server/cpu10/runtime
0

hv# cat /sys/kernel/debug/sched/fair_server/cpu10/period
1000000000


Here is the QEMU command line. The guest kernel has below configs.

CONFIG_PARAVIRT=y
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y

qemu-system-x86_64 \
-machine q35,kernel_irqchip=split \
-accel kvm -cpu host \
-smp 4 -m 8G \
-hda boot.qcow2 \
-monitor stdio -vnc :8 \
-net nic -net user,hostfwd=tcp::5028-:22 \
-kernel mainline-linux/arch/x86_64/boot/bzImage \
-append "root=/dev/sda1 init=/sbin/init text loglevel=7 console=ttyS0"


Pin vCPU 2 to pCPU 10.

(qemu) info cpus
* CPU #0: thread_id=12525 model=host
  CPU #1: thread_id=12526 model=host
  CPU #2: thread_id=12528 model=host
  CPU #3: thread_id=12529 model=host

hv$ sudo taskset -pc 10 12528


Run runtime_stall_detector_v2.py in the guest VM. It creates five threads
pinned to vCPU 2. Each thread periodically reads the clocksource and
detects sudden forward jumps in time, indicating that the thread was
previously stalled. The source code is appended to the end of this cover
letter email.

[root@vm ~]# ./runtime_stall_detector_v2.py 2 5
started 5 tasks on guest cpu 2
worker pids: 441 442 443 444 445
trigger host-side vCPU starvation now
worker=3 pid=443 pinned_cpu=2
worker=1 pid=441 pinned_cpu=2
worker=2 pid=442 pinned_cpu=2
worker=4 pid=444 pinned_cpu=2
worker=5 pid=445 pinned_cpu=2

Now run the following command on the KVM host to preempt and stall threads
on pCPU 10. As a result, vCPU 2 and the five threads pinned to it will also
be stalled for 10 seconds.

hv$ sudo timeout 10s taskset -c 10 chrt -f 90 bash -c 'while :; do :; done'


Ideally, we expect each of the five threads to observe a 10-second forward
jump. However, one thread running on vCPU 2 during the stall will incur an
additional penalty.

[root@vm ~]# ./runtime_stall_detector_v2.py 2 5
... ...
1787476745.895051479: worker=5 pid=445 gap=9.997750 sec
1787476745.895614147: worker=1 pid=441 gap=10.004634 sec
1787476745.898544550: worker=2 pid=442 gap=10.005462 sec
1787476745.901545286: worker=4 pid=444 gap=10.006361 sec
1787476785.617044926: worker=3 pid=443 gap=49.718478 sec --> additional penalty!


The issue is no longer reproducible when the patchset is applied to both
the KVM guest and host.

1787507053.410693884: worker=4 pid=436 gap=9.995703 sec
1787507053.411839247: worker=5 pid=437 gap=10.004244 sec
1787507053.413943768: worker=2 pid=434 gap=10.002146 sec
1787507053.414848804: worker=1 pid=433 gap=10.005150 sec
1787507053.419051886: worker=3 pid=435 gap=10.005138 sec


Dongli Zhang (2):
  KVM: x86: Update stealtime before clearing preempted state
  sched/core: Defer preempted remote vCPU task clock updates

 arch/x86/kvm/x86.c   | 58 ++++++++++++++++++++++++++---------------------
 kernel/sched/core.c  | 24 ++++++++++++++++++++
 kernel/sched/sched.h |  1 +
 3 files changed, 57 insertions(+), 26 deletions(-)

base-commit: 818bebeb63dd6bf5f4e07e145f6cdbace520a34c

Thank you very much!

Dongli Zhang


----------------------

[root@vm ~]# cat runtime_stall_detector_v2.py
#!/usr/bin/env python3
import multiprocessing as mp
import os
import signal
import subprocess
import sys
import time


def worker(cpu, index, done):
    os.sched_setaffinity(0, {cpu})
    pid = os.getpid()

    print(f"worker={index} pid={pid} pinned_cpu={cpu}", flush=True)

    prev = time.monotonic_ns()
    while True:
        now = time.monotonic_ns()
        gap = (now - prev) / 1e9

        if gap > 0.5:
            print(f"{time.time():.9f}: worker={index} pid={pid} gap={gap:.6f} sec", flush=True)
            if gap > 30:
                done.set()
                return

        prev = now


def kill_old_detectors():
    subprocess.run(["pkill", "-f", "runtime_stall_detector.py"], check=False)


def main():
    cpu = int(sys.argv[1]) if len(sys.argv) > 1 else 2
    nr = int(sys.argv[2]) if len(sys.argv) > 2 else 5

    kill_old_detectors()

    done = mp.Event()
    procs = [mp.Process(target=worker, args=(cpu, i, done)) for i in range(1, nr + 1)]

    for proc in procs:
        proc.start()

    print(f"started {nr} tasks on guest cpu {cpu}", flush=True)
    print("worker pids:", " ".join(str(proc.pid) for proc in procs), flush=True)
    print("trigger host-side vCPU starvation now", flush=True)

    try:
        while not done.wait(1):
            pass
    except KeyboardInterrupt:
        pass
    finally:
        for proc in procs:
            if proc.is_alive():
                os.kill(proc.pid, signal.SIGTERM)
        for proc in procs:
            proc.join()


if __name__ == "__main__":
    main()

