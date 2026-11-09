Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794244323;
	b=aeBIQLisp0vVm74g1nhCLtFmkiE4CebcfV9r1Lg+vtZ2SxcdaXNy/DeIMmnsef9yncOK
	 omh/EJo3l6X6z+3WOsjdLYHE4zYpwr0iRFTsxiYzQnrB4488NCzpbPjCiTyfhaamcepP7
	 LePMhWyC+5BGRIiWxQSidpHgXhRI6i8ckIF52FiQMwq5WQ5Sf0nJ/myTqJDHv757OCnqv
	 eY3tDBPC3w37UD78Qhpeuc14h05kQgxdljGAHOYIOg4cGDRX/J8DUYxXKNPhTXFwpnEhh
	 oVgacjW9QUkDiLnPpl0JNyX+SmtG82YZq4I5DT9KbKgwtRaeMJ7SQlH6xtKpPM/vvDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794244323;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Reinject:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=2oy46UchJMfFJizGJ2uCvfca/GcB6fo1sNhMCuF7ekg=;
	b=L1Y1Wt39FutusXkqFp9kANseHX21A6kb+FHjOWwxWuwqpUOzUTTn+8JvqA7FQVkxCIHe
	 eRtCAGRafHrUjjW+sJpSYN0TOfGy6+EtSEct+JqSKkTHWGW4M2aCAOAoQdEnQ+w7NO2Eg
	 Fd/mcSxhPDKfqWmyfT/ipw39J4vyoysoR40QrTwKeH8ZADcOBbAbtv5tNOMbms4Y/cZpT
	 jR3eAjxzYXfMws9eMoVxBSihPscA845/bvgtA2BZM2BZw3xOiw+2U5gZu1f2ZzcGKZi13
	 f7vEaAoeZDOgz5aMfCv3YIE2JWUla5gTVL9IQfLp7t7pAj9DBEfKDEimMvGqKn56fUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OyaQQw4Q;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D46606A326
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 17:12:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41D46606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OyaQQw4Q
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9DEju51857823;
	Mon, 9 Nov 2026 17:11:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=2oy46UchJMfFJizGJ
	2uCvfca/GcB6fo1sNhMCuF7ekg=; b=OyaQQw4QUjjrpzs6DU2qn8Ei9V8v0K24W
	63Qb5n/z+21Cxv5FAU2AbU9rFPnloEROO7LfuQpBMyC81Bkc+0OHNJ6+VXI5I0+V
	stzt+nU5jG4JVDLOXY+7j4XBTHPaGwqEYo4L9cUkaovjg2rqvl4xYRUCVCgsHahG
	cguNRP4I0EayZglQJRxLVxpBm/dVfY2Djfotn+DQgKAqMb0b1wcmXHiAIb4UYSFh
	a2tuGx3EAkEI5v6YTskuCFwR41oEIGjbteRVlThK9lFBzfHg/uiatwsZn1Yl0Vxh
	zCoNYKvJ5edisZlzIQALcWgsw3SV+ztkL6HgQB+cu46Z/AsqDY7wA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsunsykct-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 17:11:27 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9Gl3If131307;
	Mon, 9 Nov 2026 17:11:26 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hth0y1guc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 17:11:26 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A9HBMlE44695856
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Nov 2026 17:11:23 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D1CCB20040;
	Mon,  9 Nov 2026 17:11:22 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 579ED20043;
	Mon,  9 Nov 2026 17:11:22 +0000 (GMT)
Received: from a46lp03.lnxne.boe (unknown [9.87.84.240])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Nov 2026 17:11:22 +0000 (GMT)
From: Bjoern Walk <bwalk@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Steffen Eiden <seiden@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>,
        Bjoern Walk <bwalk@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@kernel.org>,
        Igor Mammedov <imammedo@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>,
        Song Gao <17746591750@163.com>, Bibo Mao <maobibo@loongson.cn>,
        Xianglai Li <lixianglai@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Alex Williamson <alex@shazbot.org>,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        Marcelo Tosatti <mtosatti@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        Amit Machhiwal <amachhiw@linux.ibm.com>,
        Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Alistair Francis <alistair.francis@wdc.com>,
        Weiwei Li <liwei1518@gmail.com>,
        Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
        Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
        Chao Liu <chao.liu@processmission.com>, Peter Xu <peterx@redhat.com>,
        Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
        kvm@vger.kernel.org (open list:Overall KVM CPUs),
        qemu-s390x@nongnu.org (open list:S390 PCI),
        qemu-arm@nongnu.org (open list:ARM TCG CPUs),
        qemu-ppc@nongnu.org (open list:PowerPC TCG CPUs),
        qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs)
Subject: [RFC Patch 3/8] kvm: Prefer including "system/kvm.h" over <linux/kvm.h>
Date: Mon,  9 Nov 2026 18:10:29 +0100
Message-ID: <20261109171036.3806884-4-bwalk@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109171036.3806884-1-bwalk@linux.ibm.com>
References: <20261109171036.3806884-1-bwalk@linux.ibm.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA2NiBTYWx0ZWRfX7eOTmVR4NBFt
 vjth9PGTZQ2/uTz9QeOFq2UEKpgR5hZgFXK6shEK9ZMdLR+nLgsSNeaUFJJsCmt6OcIHM8Dl9IS
 wlSArnj1XOp6zqx5PyzlYyzuBpD5OD91ivFanClEQlK3liJVGMitlMoPT5ZLiQch+Ps4Y7AORu6
 pKMH0Rny4yhMlMD7OL1J2QCrQRkK35CWzTYDzgYwi95ZLVJTA22jEOivZEYnpUgTGpws7VgFDSq
 V4Jc6hLPL7vk821D18MjfnGla0JQMyqdc2UV+Aa5/oPcYNtjUPrDEsP06GBzWip0ryc4TC71dqo
 HLpx+4bVPrqeU2UCC6XoNcCvlP/mZrvxrcCfcqs+5HvzABOPAwT8t2kk7dqGVsHURQ7Y45b+4nh
 pehAGORddxwWwxnFCB9ZL9q/vF7z6oeL+JfAZUHRpMDrapiXfcIJZfV2IdAR+6vQIbOrehAyMhU
 tUOcGt/C7VmR/cPWgmg==
X-Proofpoint-ORIG-GUID: Ipap74PMJo4MHc9JHSGlzMkkjc9sOE2N
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA2NiBTYWx0ZWRfX1UQXTnUNN/Pl
 8NPyv2ZdExEDsNyRjoeAsxpKkwlGdlAdbnOSh/hwWLrPF0AHAFtJmnV6vay+qbtVzl5YA1cCXYF
 ZwSnUvakutWlqUXIDrbpsSELsnRETaA=
X-Authority-Analysis: v=2.4 cv=euZKXYpX c=1 sm=1 tr=0 ts=6af1fec0 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=ln_9VpdSANE7LO6HYOUA:9
X-Proofpoint-GUID: DehO9Ok2gL7DvHr44IvayByzvmd7lsFz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1011 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090066

"system/kvm.h" provides scaffolding around usage of KVM definitions from
<linux/kvm.h> and can act as the central include for KVM-related definitions.

Signed-off-by: Bjoern Walk <bwalk@linux.ibm.com>
---
 accel/kvm/kvm-accel-ops.c              | 1 -
 accel/kvm/kvm-all.c                    | 2 +-
 backends/hostmem-memfd.c               | 1 -
 hw/hyperv/hyperv.c                     | 1 -
 hw/i386/kvm/clock.c                    | 1 -
 hw/i386/kvm/i8254.c                    | 1 -
 hw/i386/kvm/xen_evtchn.c               | 1 -
 hw/i386/kvm/xen_overlay.c              | 1 -
 hw/intc/loongarch_dintc_kvm.c          | 1 -
 hw/intc/loongarch_extioi_kvm.c         | 1 -
 hw/s390x/s390-pci-kvm.c                | 2 +-
 hw/vfio/kvm-helpers.c                  | 1 -
 hw/vfio/kvm-spapr.c                    | 2 +-
 include/system/kvm.h                   | 1 +
 target/arm/kvm-consts.h                | 3 ++-
 target/arm/kvm.c                       | 2 --
 target/i386/kvm/kvm.c                  | 2 +-
 target/i386/kvm/kvm_i386.h             | 2 --
 target/i386/sev.c                      | 1 -
 target/loongarch/cpu.c                 | 3 ---
 target/loongarch/kvm/kvm.c             | 1 -
 target/ppc/kvm.c                       | 2 --
 target/riscv/kvm/kvm-cpu.c             | 2 --
 target/s390x/kvm/kvm.c                 | 2 +-
 target/s390x/kvm/pv.c                  | 2 --
 tests/qtest/migration/framework.c      | 2 +-
 tests/qtest/migration/migration-util.c | 2 +-
 27 files changed, 10 insertions(+), 33 deletions(-)

diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
index 47244d33..df29c130 100644
--- a/accel/kvm/kvm-accel-ops.c
+++ b/accel/kvm/kvm-accel-ops.c
@@ -25,7 +25,6 @@
 #include "qemu/guest-random.h"
 #include "qapi/error.h"
 
-#include <linux/kvm.h>
 #include "kvm-cpus.h"
 
 static void *kvm_vcpu_thread_fn(void *arg)
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 411f28dd..178788d2 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -17,7 +17,7 @@
 #include <sys/ioctl.h>
 #include <poll.h>
 
-#include <linux/kvm.h>
+#include "system/kvm.h"
 
 #include "qemu/atomic.h"
 #include "qemu/option.h"
diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
index 46489212..9341169e 100644
--- a/backends/hostmem-memfd.c
+++ b/backends/hostmem-memfd.c
@@ -20,7 +20,6 @@
 #include "qom/object.h"
 #include "migration/cpr.h"
 #include "system/kvm.h"
-#include <linux/kvm.h>
 #include "qapi/qapi-type-infos-common.h"
 
 OBJECT_DECLARE_SIMPLE_TYPE(HostMemoryBackendMemfd, MEMORY_BACKEND_MEMFD)
diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
index 900ff802..0db87a5b 100644
--- a/hw/hyperv/hyperv.c
+++ b/hw/hyperv/hyperv.c
@@ -15,7 +15,6 @@
 #include "system/memory.h"
 #include "exec/target_page.h"
 #include "exec/cpu-common.h"
-#include "linux/kvm.h"
 #include "system/kvm.h"
 #include "system/physmem.h"
 #include "qemu/bitops.h"
diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
index e3dad136..3c2601a7 100644
--- a/hw/i386/kvm/clock.c
+++ b/hw/i386/kvm/clock.c
@@ -27,7 +27,6 @@
 #include "exec/cpu-common.h"
 #include "qapi/error.h"
 
-#include <linux/kvm.h>
 #include "qom/object.h"
 
 #define TYPE_KVM_CLOCK "kvmclock"
diff --git a/hw/i386/kvm/i8254.c b/hw/i386/kvm/i8254.c
index 70e8fd83..d99ee462 100644
--- a/hw/i386/kvm/i8254.c
+++ b/hw/i386/kvm/i8254.c
@@ -24,7 +24,6 @@
  */
 
 #include "qemu/osdep.h"
-#include <linux/kvm.h>
 #include "qapi/qapi-types-machine.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
diff --git a/hw/i386/kvm/xen_evtchn.c b/hw/i386/kvm/xen_evtchn.c
index 9379383e..b8982548 100644
--- a/hw/i386/kvm/xen_evtchn.c
+++ b/hw/i386/kvm/xen_evtchn.c
@@ -43,7 +43,6 @@
 
 #include "system/kvm.h"
 #include "system/kvm_xen.h"
-#include <linux/kvm.h>
 #include <sys/eventfd.h>
 
 #include "hw/xen/interface/memory.h"
diff --git a/hw/i386/kvm/xen_overlay.c b/hw/i386/kvm/xen_overlay.c
index 74cadffb..4cb16e31 100644
--- a/hw/i386/kvm/xen_overlay.c
+++ b/hw/i386/kvm/xen_overlay.c
@@ -25,7 +25,6 @@
 
 #include "system/kvm.h"
 #include "system/kvm_xen.h"
-#include <linux/kvm.h>
 
 #include "hw/xen/interface/memory.h"
 
diff --git a/hw/intc/loongarch_dintc_kvm.c b/hw/intc/loongarch_dintc_kvm.c
index 1137bcd9..9bacf5e7 100644
--- a/hw/intc/loongarch_dintc_kvm.c
+++ b/hw/intc/loongarch_dintc_kvm.c
@@ -7,7 +7,6 @@
 
 #include "qemu/osdep.h"
 #include "hw/intc/loongarch_dintc.h"
-#include "linux/kvm.h"
 #include "qapi/error.h"
 #include "system/kvm.h"
 
diff --git a/hw/intc/loongarch_extioi_kvm.c b/hw/intc/loongarch_extioi_kvm.c
index aa2e8c75..d17d0511 100644
--- a/hw/intc/loongarch_extioi_kvm.c
+++ b/hw/intc/loongarch_extioi_kvm.c
@@ -7,7 +7,6 @@
 
 #include "qemu/osdep.h"
 #include "hw/intc/loongarch_extioi.h"
-#include "linux/kvm.h"
 #include "qapi/error.h"
 #include "system/kvm.h"
 
diff --git a/hw/s390x/s390-pci-kvm.c b/hw/s390x/s390-pci-kvm.c
index 9eef4fc3..12b6e8ba 100644
--- a/hw/s390x/s390-pci-kvm.c
+++ b/hw/s390x/s390-pci-kvm.c
@@ -11,7 +11,7 @@
 
 #include "qemu/osdep.h"
 
-#include <linux/kvm.h>
+#include "system/kvm.h"
 
 #include "kvm/kvm_s390x.h"
 #include "target/s390x/kvm/pv.h"
diff --git a/hw/vfio/kvm-helpers.c b/hw/vfio/kvm-helpers.c
index 5e73dddc..429e266e 100644
--- a/hw/vfio/kvm-helpers.c
+++ b/hw/vfio/kvm-helpers.c
@@ -21,7 +21,6 @@
 #include "qemu/osdep.h"
 #include <sys/ioctl.h>
 
-#include <linux/kvm.h>
 #include "system/kvm.h"
 #include "exec/cpu-common.h"
 #include "hw/vfio/vfio-device.h"
diff --git a/hw/vfio/kvm-spapr.c b/hw/vfio/kvm-spapr.c
index ad71c5a8..beb53651 100644
--- a/hw/vfio/kvm-spapr.c
+++ b/hw/vfio/kvm-spapr.c
@@ -7,7 +7,7 @@
 #include "qemu/osdep.h"
 #include <sys/ioctl.h>
 #include <linux/vfio.h>
-#include <linux/kvm.h>
+#include "system/kvm.h"
 
 #include "hw/vfio/vfio-container-legacy.h"
 #include "hw/vfio/kvm-spapr.h"
diff --git a/include/system/kvm.h b/include/system/kvm.h
index 5d7c0f98..84c2efe9 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -29,6 +29,7 @@
 # endif
 #else
 # define CONFIG_KVM_IS_POSSIBLE
+# include <linux/kvm.h>
 #endif
 
 #ifdef CONFIG_KVM_IS_POSSIBLE
diff --git a/target/arm/kvm-consts.h b/target/arm/kvm-consts.h
index 9fba3e88..1e4eb9e7 100644
--- a/target/arm/kvm-consts.h
+++ b/target/arm/kvm-consts.h
@@ -14,9 +14,10 @@
 #ifndef ARM_KVM_CONSTS_H
 #define ARM_KVM_CONSTS_H
 
+#include "system/kvm.h"
+
 #ifdef COMPILING_PER_TARGET
 #ifdef CONFIG_KVM
-#include <linux/kvm.h>
 #include <linux/psci.h>
 #define MISMATCH_CHECK(X, Y) QEMU_BUILD_BUG_ON(X != Y)
 #endif
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index df86ad38..99d8f503 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -13,8 +13,6 @@
 #include "qemu/osdep.h"
 #include <sys/ioctl.h>
 
-#include <linux/kvm.h>
-
 #include "qemu/timer.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index e29ecaba..47ee0590 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -24,7 +24,7 @@
 #include <sys/syscall.h>
 #include <sys/resource.h>
 
-#include <linux/kvm.h>
+#include "system/kvm.h"
 #include <linux/kvm_para.h>
 #include "standard-headers/asm-x86/kvm_para.h"
 #include "hw/xen/interface/arch-x86/cpuid.h"
diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
index 2b653442..7166353b 100644
--- a/target/i386/kvm/kvm_i386.h
+++ b/target/i386/kvm/kvm_i386.h
@@ -44,8 +44,6 @@ void kvm_request_xsave_components(X86CPU *cpu, uint64_t mask);
 
 #ifdef CONFIG_KVM
 
-#include <linux/kvm.h>
-
 typedef struct KvmCpuidInfo {
     struct kvm_cpuid2 cpuid;
     struct kvm_cpuid_entry2 entries[KVM_MAX_CPUID_ENTRIES];
diff --git a/target/i386/sev.c b/target/i386/sev.c
index 604c2255..3e19f6ec 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -13,7 +13,6 @@
 
 #include "qemu/osdep.h"
 
-#include <linux/kvm.h>
 #include <linux/kvm_para.h>
 #include <linux/psp-sev.h>
 
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 1f302226..5f242e19 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -25,9 +25,6 @@
 #include "system/reset.h"
 #endif
 #include "vec.h"
-#ifdef CONFIG_KVM
-#include <linux/kvm.h>
-#endif
 #include "tcg/tcg_loongarch.h"
 #include "disas/capstone.h"
 
diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index 957e73eb..5100024e 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -8,7 +8,6 @@
 #include "qemu/osdep.h"
 #include "exec/target_long.h"
 #include <sys/ioctl.h>
-#include <linux/kvm.h>
 #include "asm-loongarch/kvm_para.h"
 #include "qapi/error.h"
 #include "qemu/timer.h"
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index cd19f7a6..ac49a3dd 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -19,8 +19,6 @@
 #include <sys/ioctl.h>
 #include <sys/vfs.h>
 
-#include <linux/kvm.h>
-
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "cpu.h"
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 5beb6023..eba1b96a 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -20,8 +20,6 @@
 #include <sys/ioctl.h>
 #include <sys/prctl.h>
 
-#include <linux/kvm.h>
-
 #include "qemu/timer.h"
 #include "qapi/error.h"
 #include "qapi/qapi-builtin-type-infos.h"
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index 76dd1e67..bd824fad 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -21,7 +21,7 @@
 #include "qemu/osdep.h"
 #include <sys/ioctl.h>
 
-#include <linux/kvm.h>
+#include "system/kvm.h"
 #include <asm/ptrace.h>
 
 #include "cpu.h"
diff --git a/target/s390x/kvm/pv.c b/target/s390x/kvm/pv.c
index 3d508165..afea9e3f 100644
--- a/target/s390x/kvm/pv.c
+++ b/target/s390x/kvm/pv.c
@@ -11,8 +11,6 @@
  */
 #include "qemu/osdep.h"
 
-#include <linux/kvm.h>
-
 #include "qemu/units.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index b7aef6b2..60f85b72 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -27,7 +27,7 @@
 #include "qemu/sockets.h"
 
 #ifdef CONFIG_LINUX
-#include <linux/kvm.h>
+#include "system/kvm.h"
 #include <sys/ioctl.h>
 #endif
 
diff --git a/tests/qtest/migration/migration-util.c b/tests/qtest/migration/migration-util.c
index db66d8b2..e145c3f8 100644
--- a/tests/qtest/migration/migration-util.c
+++ b/tests/qtest/migration/migration-util.c
@@ -35,7 +35,7 @@
 
 /* For dirty ring test; so far only x86_64 is supported */
 #if defined(__linux__) && defined(HOST_X86_64)
-#include "linux/kvm.h"
+#include "system/kvm.h"
 #endif
 
 GQueue *tests;
-- 
2.56.0

