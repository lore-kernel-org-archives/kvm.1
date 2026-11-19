Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=173.38.203.67
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795065264;
	b=ZwwA5LTBvYIydL1cO7Z8wgblA64Z1pVdIVqrbp8qzSymtSslBOsVsLOZItaCt7yYtBQ3
	 nz+hEf+nHtFI+oSebDyrV3hkiqXcbmOIF4rdJwQTyb2A/2pXPrWx7rjyzfONrYRiyv+p3
	 r1kaK3iD34cS2gIsfFPPCQODuMhKEVNmlhrTJ+l9W1yduY5TnkbAvTX5WE8S90GUJ5cUO
	 3WJzoDjEI+d0xHUcWRsVycsLaH/V4Bf+5JgnJiUzU064drjtGPS39ZHZRM4fbSNSsAx41
	 IMECTJkbm+654Foh6pDpSW+9/H7d+OONRv1InRVcQXvm7XHW4JnHY6XeiOwzesaW26g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795065264;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IPAS-Result:IronPort-Data:IronPort-HdrOrdr:X-Talos-CUID:
	 X-Talos-MUID:X-IronPort-Anti-Spam-Filtered:X-IronPort-AV:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Outbound-Client-TLS:X-Outbound-SMTP-Client:X-Outbound-Node;
	bh=x1V5vovvmUg8PTQp+3KopB8wgaV634VWBQpHGZidxrI=;
	b=ryxzCswssX1OwZiAVGHJxx4vklYBhPSOTEeHL0RSXUTzbNPRr2lHgLpeWq24jLTySuqr
	 FHXS2J/yLXp9/V/bRAb+kF8wX8G4HJ/8nie3EH2RYgk+RW4iyZQgYSyMSGc+wM8t02QcU
	 tYMFJmRZ2aGMpga/jrJ9782z3SA9589k+VTPCN+9sT+jiIyTo1mmIsMqM6hIiqni0qwpI
	 QHgeb1hPNNEjzmh35JqahjZhRnniHICOM5qz+8IURDt6c0aj7Eurde6E5QTo95QCTt2xT
	 n8C87yjccKC1JAAdjGsE8PTIoYQqf/gldQDG3Ry5Ucy44ln6+XljXky40bp3urrnS3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cisco.com;
	spf=pass smtp.mailfrom=cisco.com;
	dkim=pass header.d=cisco.com header.i=@cisco.com header.a=rsa-sha256 header.s=iport01 header.b=BgZPgdev;
	arc=none smtp.remote-ip=173.38.203.67
Received: from aer-iport-5.cisco.com (aer-iport-5.cisco.com [173.38.203.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80B8606A320;
	Thu, 19 Nov 2026 05:14:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D80B8606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cisco.com header.i=@cisco.com header.a=rsa-sha256 header.s=iport01 header.b=BgZPgdev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=2447; q=dns/txt;
  s=iport01; t=1795065263; x=1796274863;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x1V5vovvmUg8PTQp+3KopB8wgaV634VWBQpHGZidxrI=;
  b=BgZPgdevqFZZ2MmGQmH6ENvKMqCe1CMS9AE2RQbJZS1RTBPLNj2ch3mj
   37Fbd3aST30lyOlAjVWQn3vFhFSACXfJr+bAVpwt5un0LeWc0xh0rcGbL
   lK0nQblNsuyZaMH6J6iYDH3vqaDicjqXSO5O7NY/K3M8dftKwMIUf9Nvr
   oQwMZvkoX63hRw9HL5VkOCDVi8sLK4Uay1od0vUhEP1ebufK6b1zEwgZB
   FWJggvNJKzSsuaIwesR7BZiHtangOvjloNO0lQP8xGNBIORcpoqwLA27H
   PP7L9/w/k8rfdxXxKDsXnOu5EgoHWEH2rFLb1jP8kAR0TShk6fpQdHXFJ
   g==;
X-CSE-ConnectionGUID: tNg7W4LPSz+XUX8F0x4brw==
X-CSE-MsgGUID: 86kEBxBaR0yyu7wXZI7Sig==
X-IPAS-Result: =?us-ascii?q?A0BuBAAvhf5q/9JK/pBaglkCglWBVUOFIJF0A4ETkD2OV?=
 =?us-ascii?q?w8BAQEPUQQBAYUFAo4gAiY3Bg4BAgQDAgMBAQEBAQEBAQEBAQEKAQEFAQEBA?=
 =?us-ascii?q?gEHBYEOE4ZcSQGJSAGGAAEBAQIBIwQLAUYFCwsaAiYCAlaDG4JOJwO5Nnp/M?=
 =?us-ascii?q?4EB3kmBaAELFAGBCi6FdIJuAYUDgRGEYicbgUlEgRWCdAcxPoEFAYQKgw+Ca?=
 =?us-ascii?q?gSCIoEMgQeHCYU9inlICngcA1ksAVUTDQoLBwWBJUMDNRIqFSMPPAUtHYEjO?=
 =?us-ascii?q?xcRHlgbBgUSICpAQ1uBEoEDXYErKF0BAh9GLRWBdgKCUYEjXQIBSUEOB0VTC?=
 =?us-ascii?q?SVDEkckIggSCQETGiwKgRo1PAkmPxUMWwwIAxoFGiYCHwgCCwIMdCgREBMdH?=
 =?us-ascii?q?iQvBRomPhsKgQwnHx4bDgIOGA1IESwUIxUZBD0BbgeWallaWjxEMiwBRAOlJ?=
 =?us-ascii?q?6ERhCuBaJ92GjOqcpkIo20eGTeEaoF+JoFZMxoIGxWDI1IZD1eNVwsLHNACJ?=
 =?us-ascii?q?m8CBwIHDgMLh1yMCgEB?=
IronPort-Data: A9a23:p/r/hqrMxo4dQxq3G4WrzVa9EzFeBmIfZBIvgKrLsJaIsI4StFCzt
 garIBnQb/jcM2PweN4la9/j8kgOvJXRz9ZkTgVspC9jQS9H9ePIVI+TRqvS04x+DSFioGZPt
 Zh2hgzodZhsJpPkjk7zdOWn9T8sj/zgqoPUUIbsIjp2SRJvVBAvgBdin/9RqoNziLBVOSvV0
 T/Ji5OZYgDNNwJcaDpOtfva8UM355wehRtB1rAATaET1LPhvyF94KI3fcmZM3b+S49IKe+2L
 86r5K255G7Q4yA2AdqjlLvhGmVSKlIFFVHT4pb+c/HKbilq/kTe4I5iXBYvQRs/ZwGyojxE4
 I4lWapc5useFvakdOw1C3G0GszlVEFM0OevzXOX6aR/w6BaGpfh660GMa04AWEX0vpRDj5xq
 dggEyJOXi2z18zu0O6xUPY506zPLOGzVG8eknht13TdSP0hW52GG/SM7t5D1zB2jcdLdRrcT
 5NFNXw1MUiGPEEJYA5PYH49tL/Aan3XaDREqUmVpqof6GnIxws327/oWDbQUoHbHpgJxR7Az
 o7A1zSnATwwJPaW82KU42/zmd/9vHzAWY1HQdVU8dYv2jV/3Fc7ExAfU1mwifa+jUG6VpRUL
 El80jIkqq4g9UqqZsPwUx2xvDiPuRt0c9lOFsUk5wyXjKnZ+QCUAi4DVDEpQNgnstImAD8nz
 FmEm/v3CjF19r6YU3SQ8vGTtzzaBMQOBWYPf2oACAAC+dSm+NB1hRPURdElG6mw5jHoJQzNL
 /mxhHBWr90uYQQjjs1XIXivb+qQm6X0
IronPort-HdrOrdr: A9a23:4IR7+KsmrvG1cS3kGv2COSen7skDUNV00zEX/kB9WHVpmwKj+/
 xG+85rsiMc6QxhPE3I9urvBEDtexnhHNtOkOos1NSZLWzbUQmTTb2KhLGKq1bd8m/Fh4xgPM
 xbHJSWZuecMbEDt6bHyTj9Nco8y9+a963tr+Lfw3BxCTxOUchbnmFE4sLxKDwPeOGAbqBJba
 ah2g==
X-Talos-CUID: 9a23:Q6g/HG6Xb7Ol4kWxS9ss6GgbRf95VkXm3jTgHn/oJz55FLePVgrF
X-Talos-MUID: 9a23:uR456wZNUMjUpOBT52HvqRtyHs5Su7W/FR8Soacn5PKFOnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,220,1787011200"; 
   d="scan'208";a="59354300"
Received: from aer-l-core-09.cisco.com ([144.254.74.210])
  by aer-iport-5.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 19 Nov 2026 05:14:15 +0000
Received: from satishkh-l-mj0bbv6x.cisco.com (unknown [10.25.129.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by aer-l-core-09.cisco.com (Postfix) with ESMTPS id CE61B180001F6;
	Thu, 19 Nov 2026 05:14:13 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
To: seanjc@google.com
Cc: pbonzini@redhat.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: Send reschedule IPIs instead of SMP function calls for non-waiting requests
Date: Wed, 18 Nov 2026 21:14:07 -0800
Message-ID: <20261119051407.886480-1-satishkh@cisco.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <av5Crz-e2PaTNAjK@seanjc-mac.roam.internal>
References: <20261117205428.3717-1-seanjc@google.com> <20261118211152.3430478-1-satishkh@cisco.com> <av5Crz-e2PaTNAjK@seanjc-mac.roam.internal>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.129.52];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.129.52, [10.25.129.52]
X-Outbound-Node: aer-l-core-09.cisco.com

Hi Sean,

> Ugh, yeah, that WARN could be problematic.  Thanks much!

I tried a guard on top of your patch. The non-waiting path checks
cpu_active() before sending a reschedule IPI. Both callers hold get_cpu()
through this helper and the send. CPU-down clears cpu_active() and then
waits for preempt-disabled readers before taking the CPU offline. That
appears to protect the interval between the check and the IPI.

This is the incremental diff I built and tested:

--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -253,9 +253,12 @@
 	 */
 	if (kvm_request_needs_ipi(vcpu, req)) {
 		cpu = READ_ONCE(vcpu->cpu);
-		if (cpu != -1 && cpu != current_cpu) {
-			if (!(req & KVM_REQUEST_WAIT))
+		if (cpu != current_cpu && (unsigned int)cpu < nr_cpu_ids) {
+			if (!(req & KVM_REQUEST_WAIT)) {
+				if (!cpu_active(cpu))
+					return;
 				smp_send_reschedule(cpu);
+			}
 			__cpumask_set_cpu(cpu, tmp);
 		}
 	}

With a four-vCPU VFIO guest, three ENIC VF driver reloads passed
bidirectional traffic. During the same run, 20 CPU offline/online cycles completed. The
trace recorded 16 non-waiting KVM requests and 11 reschedule IPIs from
kvm_make_vcpu_request(), all on the VFIO IRQ-bypass registration path.
The traced IPIs did not target the CPU being offlined. There was no new
host warning. On a second Intel system, five irqfd_test/irq_test cycles
and ten CPU offline/online cycles passed, although its trace only saw
waiting requests.

I also tried to force two CPU-down orderings with a separate test-only
kvm.ko. It started offlining the target CPU from kernel work while the
non-waiting request was held (1) before cpu_active() and (2) after an
active result but before smp_send_reschedule(). In both runs the target
remained active throughout a 1.2-second hold; CPU-down completed after
the request returned. There was no new warning. These runs did not
exercise the inactive-CPU branch or reproduce an offline-CPU IPI.

Source inspection suggests a reason: CPU-down's hotplug write lock uses
RCU synchronization, which can wait for a preempt-disabled KVM request
before reaching sched_cpu_deactivate(). I did not trace that wait.
CPU-down could instead reach that point before a new KVM request starts.
I have not proved that such a request still sees a vCPU requiring an IPI.
Would you consider the guard worthwhile for that ordering, or does the
vCPU mode/CPU ordering exclude the target?

Thanks,
Satish
