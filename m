Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.222
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793549968;
	b=C7PW0NnwMQzMwSvrJJUQcB/b3phDxFfMR0/lNVNZ3Y/6ZxyCyGRifprJwBfGnDbyjNPD
	 9Ptux+eX01xH4ERxqW8dEh9Mo7AIb4UNorOJZbVZClR3NahEMachx24PEaLsAjGb1P9/g
	 rc/qCVcbtmWS5GqQJY0qL6HxpvYQ4pO6iUt41HcHRuBntdefChU+Hsu2xNZp34guTpcK9
	 gYLiXCzNA7QT0nDORGiyN9WdHgVJzxsyOexYKnzcqgoV3JUkgLEp6f37XAJUX4Iz45d4R
	 iYiwYGsYspT4ryi5A+p+RpG+j+BxyA2DG6G6Pv2iwsEqMIR62v4jcqekkBMJqoRlOKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793549968;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Received:From:
	 To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-originating-ip:Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=TNSlYSGydi/RSdg73wNRJVezKMRukVFeRxk/X9GiV3k=;
	b=LIkYsXwBWXFNwp6cTAD6sNRkSNqJ2cc+rYAGxLQEzag7Q0e0Xvh0jkB8evLyPQV9I69s
	 LQ4tg4PmFTeIMuS+/gqNhN1qor7iU0/TEcZ/oH/ksalklCZsc1upCKxluozf2b2ZXkSVz
	 jGQeNGHx/3V5Ql3hfYqNeyFxNeRtsobnKn41gHvjE8DfPENpSHcWn0JcN0F9nU6wrmdK4
	 +MK0hafoYjpdQ1666LKu2mn1/OAbIG81TcwG1+JbIN5AwqPXtz5OKq9LLuDU9cP0VXvxC
	 MJXYuqyQ4pr2c9QGlLWVqPJj1RooiICDdn4qm4gj5NQGesAAK1ljbidtpykJLQ+cjmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=p9lFpG8w;
	arc=none smtp.remote-ip=113.46.200.222
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0DE606A324;
	Sun,  1 Nov 2026 16:19:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF0DE606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=p9lFpG8w
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=TNSlYSGydi/RSdg73wNRJVezKMRukVFeRxk/X9GiV3k=;
	b=p9lFpG8wjKPkaewxDHQVos7nKa2RYx6WwE7CjzCJWJGwInoO2//vCYkgr3gYHdFcxiTS+vK56
	5O0psZSU11V5JASSHM69zqfapVffmcdw/xkxk46PZ9sBW9Xmoh69993Vj3e49DVfeQtOOj83cS6
	u2KcRViFbVpRWA4cOoc8WP0=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4jHg565q42zLlTK;
	Mon,  2 Nov 2026 00:19:06 +0800 (CST)
Received: from whupemk200013.china.huawei.com (unknown [7.152.185.76])
	by mail.maildlp.com (Postfix) with ESMTPS id E91024057A;
	Mon,  2 Nov 2026 00:19:15 +0800 (CST)
Received: from kwepemr200001.china.huawei.com (7.202.195.18) by
 whupemk200013.china.huawei.com (7.152.185.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 2 Nov 2026 00:19:15 +0800
Received: from kwepemr200001.china.huawei.com ([7.202.195.18]) by
 kwepemr200001.china.huawei.com ([7.202.195.18]) with mapi id 15.02.2562.045;
 Mon, 2 Nov 2026 00:19:14 +0800
From: "Chenzhendong (alex)" <alex.chen@huawei.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: luolongmin <luolongmin@huawei.com>, "wangyanan (Y)"
	<wangyanan55@huawei.com>
Subject: [BUG REPORT] KVM: x86: Keep kvmclock_offset monotonic across
 same-host pause/resume
Thread-Topic: [BUG REPORT] KVM: x86: Keep kvmclock_offset monotonic across
 same-host pause/resume
Thread-Index: Ad1pEq5V9k/YeJKIRqCS7n6kM8dYdw==
Date: Sun, 1 Nov 2026 16:19:14 +0000
Message-ID: <e99489abf983494d888f04bb0f901e06@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi,

While testing storage snapshots that suspend and resume a VM on the same
host (vm_stop -> snapshot -> vm_start), we observed that the guest
CLOCK_MONOTONIC jumps *backward* by the freeze duration after every
resume.

The problem
-----------

On a same-host pause/resume cycle, QEMU saves the kvmclock value at the
freeze instant (T1) via KVM_GET_CLOCK in vm_stop, and feeds it back via
KVM_SET_CLOCK in vm_start (T2 =3D T1 + freeze_duration).

kvm_vm_ioctl_set_clock() recomputes the offset unconditionally:

    kvmclock_offset =3D data.clock - now_raw_ns

with now_raw_ns sampled at T2. Since

    data.clock  =3D now_raw_ns(T1) + old_kvmclock_offset

this gives

    new_offset  =3D old_kvmclock_offset - freeze_duration

i.e. the offset is pulled back by the freeze duration.

The guest computes CLOCK_MONOTONIC from the pvclock page as:

    CLOCK_MONOTONIC =3D system_time + (rdtsc - tsc_timestamp) * mult >> shi=
ft

where system_time =3D kernel_ns + kvmclock_offset is filled by the host at
each vCPU entry. After resume the host re-samples tsc_timestamp, so the
(rdtsc - tsc_timestamp) term starts growing normally again and never
goes backward. The only term that can shrink is system_time: because
kvmclock_offset was pulled back by freeze_duration, the new system_time
is freeze_duration smaller than the value the guest last observed before
the freeze. The guest's next clock_gettime(CLOCK_MONOTONIC) therefore
reads a value freeze_duration smaller than before the freeze -- a
backward jump, violating the invariant that CLOCK_MONOTONIC never goes
backward.

The fix
-------

Only allow kvmclock_offset to move forward (or stay the same). If the
newly computed offset would be smaller than the current one, keep the
current value, so the guest clock keeps running forward and the freeze
duration is simply skipped from the guest's perspective -- which is the
expected behavior for a same-host pause/resume. This is a pure monotonic
protection with no time threshold; the normal forward path (guest boot,
KVM_CLOCK_REALTIME, cross-host migration toward a later destination host
clock) is unaffected.

    old_off =3D ka->kvmclock_offset;
    new_off =3D data.clock - now_raw_ns;
    if (new_off >=3D old_off)
            ka->kvmclock_offset =3D new_off;

Test
----

Inside the guest, pin a vCPU and call clock_gettime(CLOCK_MONOTONIC)
twice in a row, flagging any backward step. Over 50 snapshot
suspend/resume cycles the backward-step counter stays at 0 with this
patch, while the unpatched kernel reports a backward jump on every cycle
(measured freeze duration 27-36 ms).

To the best of our knowledge this scenario is not handled upstream. Any
feedback on whether monotonic protection is the right approach (vs. e.g.
teaching QEMU to feed a post-resume clock) would be much appreciated.

Signed-off-by: <Alex Chen> <alex.chen@huawei.com>
---
 arch/x86/kvm/x86.c | 19 ++++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 7a0d0e8e5c1f..000000000000 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -XXXX,XX +XXXX,XX @@ static int kvm_vm_ioctl_set_clock(struct kvm *kvm, =
void __user *argp)
 	struct kvm_arch *ka =3D &kvm->arch;
 	struct kvm_clock_data data;
 	u64 now_raw_ns;
+	s64 old_off, new_off;
 	...
 	if (ka->use_master_clock)
 		now_raw_ns =3D ka->master_kernel_ns;
 	else
 		now_raw_ns =3D get_kvmclock_base_ns();
-	ka->kvmclock_offset =3D data.clock - now_raw_ns;
+
+	/*
+	 * Monotonic protection: data.clock is the kvmclock value userspace
+	 * saved at vm_stop (freeze instant); now_raw_ns is sampled at resume.
+	 * The naive kvmclock_offset =3D data.clock - now_raw_ns pulls the
+	 * offset back to the freeze instant, which makes pvti.system_time =3D
+	 * kernel_ns + kvmclock_offset jump backward by the freeze duration ->
+	 * guest vDSO CLOCK_MONOTONIC goes backward.
+	 *
+	 * Only allow kvmclock_offset to move forward (or stay). If the new
+	 * offset would shrink, keep the old one so the guest clock keeps
+	 * running forward (the freeze duration is simply skipped from the
+	 * guest's perspective, which is the desired behavior for a same-host
+	 * pause/resume). Pure monotonic protection, no time threshold.
+	 */
+	old_off =3D ka->kvmclock_offset;
+	new_off =3D data.clock - now_raw_ns;
+	if (new_off >=3D old_off)
+		ka->kvmclock_offset =3D new_off;
 	kvm_end_pvclock_update(kvm);

