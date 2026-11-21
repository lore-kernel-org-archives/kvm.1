Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=173.38.203.68
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795274696;
	b=teU1yrR9me7d/YFenMLGVizMjCmR+ac6U8O4lg7YpmtF0FB8xqTH4FCQG9PCEcHunxt0
	 V6tKwFky434IeKbOLn12ROGiVpNHX39aImxdWppIJ/SDD93STgN+yBHwoXMlMn7awZnkq
	 +G6pmFc1kpdjtyZfEavP1fGpQtbywTn+5AUJCY9SnQJqS9UMkpUbQZijE6QQjFkAq48gq
	 2gzgI6Nk9TB32FhdcBfvGmdFA3aLMPp5Z0Lmd1uUXTNKcT5EjATxv4GwOgUEYA9+ptX4V
	 OFBKPnvXBo8FtJd8inDaL9OQaEV9iy2RT1Mwh2xpXtLcLJu0Xj7ije3zRrt3Nn7I77g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795274696;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IPAS-Result:IronPort-Data:IronPort-HdrOrdr:X-Talos-CUID:
	 X-Talos-MUID:X-IronPort-Anti-Spam-Filtered:X-IronPort-AV:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Outbound-Client-TLS:X-Outbound-SMTP-Client:X-Outbound-Node;
	bh=1m+4+4Gjf2WUHXsHYkn5LWKFpyyZZgpg0hPU7qpx32Q=;
	b=SaHCzDA3j2qW6n6Hu+lsQrLFYyHVjQp1+6yn14hQ56h8o5lBqV3X+/U81iueZj+crQf4
	 QPnfU16DwIGqCKbyhvfMaaKNnAtFkggMlOdbVjMD8KG25hBQ+ao8pE656X7bLiR4eBVw9
	 6gfoEeKxxAopDUn0Ho+ywFFlGsT+/1fPT7PLUrrQX7vUXzI3qjdxtto94GBIOKcC6p934
	 5r+lpatDueRZGTgpNp36+6rM7HXoPBd1MzM1dMcf3G/Jlmgk/K++Dq8iiVSHkbNwvociA
	 hVZPrbhic9PohkZGxG7Vm2lJjYoAXRxJR154pmYxOR42gXwPaRrT1x9EVnFkgW/Lx/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cisco.com;
	spf=pass smtp.mailfrom=cisco.com;
	dkim=pass header.d=cisco.com header.i=@cisco.com header.a=rsa-sha256 header.s=iport01 header.b=StVPJBcW;
	arc=none smtp.remote-ip=173.38.203.68
Received: from aer-iport-6.cisco.com (aer-iport-6.cisco.com [173.38.203.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F05A606A320;
	Sat, 21 Nov 2026 15:24:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F05A606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cisco.com header.i=@cisco.com header.a=rsa-sha256 header.s=iport01 header.b=StVPJBcW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=2585; q=dns/txt;
  s=iport01; t=1795274696; x=1796484296;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1m+4+4Gjf2WUHXsHYkn5LWKFpyyZZgpg0hPU7qpx32Q=;
  b=StVPJBcWLCGc61K39dDcDuUr1QSk4CZunULr3qTUTAo1K9K3ACdfxMpI
   D0TB5X/O52zyQGjfhkj6Xi4wLYceYK0U6a+xEBUKi00daDqy2QAjJ1yZV
   bqNRMvXqimfXAkKi+GYa4Jf+ZDCZBL/671Js1fTRXFb5ueIZDZHlO6Vbz
   i1xDqQGMcb6EUhSCYKSM0tzleCz6a/VFhV9XMLyx7dhmnsHJUxad+Mt1D
   a4xmbJSUFHR8q4/3zqpfq4uZypEbrUUUm2ertOckXi5rE2JWhDXiZjx0s
   143MyF+qq3kdFBPPCbXxBsZW0MHflPcd3bwNIrzhsgRjksiIT3ySvNDuK
   w==;
X-CSE-ConnectionGUID: UX6DZANYRFmbwEYirrHpRg==
X-CSE-MsgGUID: kjchhqeSTAShB4SvwOpQKQ==
X-IPAS-Result: =?us-ascii?q?A0BdAwAatgFr/89K/pBaHgEBCxIMggULhCxDSZZLA54pg?=
 =?us-ascii?q?X4PAQEBD1EEAQGFBQKOIQImNAkOAQIEAwIDAQEBAQEBAQEBAQEBCgEBBQEBA?=
 =?us-ascii?q?QIBBwWBDhOGXJATAQEBAycLAUYQCxguVgYTgwKCdQO5NYF5M4EB3kmBdBWBO?=
 =?us-ascii?q?IV0h3J2G4RiJxuBSUSBFAGCezE+gQUBigMEgiKBDIEHhwmILIgwSAqBFANZL?=
 =?us-ascii?q?AFVEw0KCwcFgSVDAzUSKhUjDzwFLR2BIzsXEXYbBgUSICpAQ1uBEoEDXYErK?=
 =?us-ascii?q?F0BAh9GLRWBdgKCUYEjXQIBSUEOB0VTCSVDEkckIggSCQETGiwKgRo1PAkmP?=
 =?us-ascii?q?xUMWwwIAxoFGiYCHwgCCwIMdCgREBMdHiQvBRomPhsKgQwnHx4bDgIfEAYZG?=
 =?us-ascii?q?A1IESwUIxUZBD5uB5N2gxhbgVsldB5Fkm2SPaERhCuBaJ92GjOqcpkIpAsZN?=
 =?us-ascii?q?4RqgWg8gVkzGggbFYMiUxkPji4LCxzSHyYyPQEBBwIHDgMLgWiRfgEB?=
IronPort-Data: A9a23:scS9yKLNnV5KeJBwFE+R8ZQlxSXFcZb7ZxGr2PjKsXjdYENShDRUm
 DEdUGmFPfveM2unfd9+YYy+oUgBuZbWyoVrGwEd+CA2RRqmiyZq6fd1j6vUF3nPRiEWZBs/t
 63yUvGZcoZpCCea9k3wWlTYhSEU/bmSQbbhA/LzNCl0RAt1IA8skhsLd9QR2uaEuvDnRVnS0
 T/Oi5eHYgH8gmQtaj58B5+r8XuDgtyj4Fv0gXRmDRx7lAe2v2UYCpsZOZawIxPQKqFIHvS3T
 vr017qw+GXU5X8FUrtJRZ6iLyXm6paLVeS/oiI+t5qK23CulQRuukoPD8fwXG8M49m/c3+d/
 /0W3XC4YV9B0qQhA43xWTEAe811FfUuFLMqvRFTvOTLp3AqfUcAzN1TPB8aD6Q+y9xZBGtR2
 M0ZMiotdiqM0rfeLLKTEoGAh+wqIdOuOMYUvWttiGmHS/0nWpvEBa7N4Le03h9p2pwIR6uCI
 ZVFL2A3M3wsYDUXUrsTIIk3gOazhnr/WzZZs1mS46Ew5gA/ySQsgeW8bYGFI7RmQ+1WnE2Yp
 nvLxFjQOREwaOeB1h2dy1GV07qncSTTHdh6+KeD3uVniVuRzUQcDxoZUVb9qv684ma7UsB3K
 EEO/Ccq668o+ySDScTlQxq+iH2JpBgRX5xXCeJSwBmHzazG4gCYLnIJQj5IdJots8pebT800
 3eXkN7zQz9iqruYTTSa7Lj8hTezPzUFaGwPfykJSSMb7NT55oI+lBTCSpBkCqHdszHuMTj92
 XWO6SM5nbhW1ZBN3KSg9leBiDWpznTUcjMICszsdjrNxmtEiESNPuRENXCzAS58Ebuk
IronPort-HdrOrdr: A9a23:FmAf8KA5C2vPr03lHemM55DYdb4zR+YMi2TDGXocdfUzSL39qy
 nAppomPHPP4gr5HUtQ+uxoW5PwJE80l6QV3WB5B97LNzUO+lHYTr2KhrGM/9SPIUDDH5ZmtZ
 tIQuxZFMD6C0R8gILR5Qm1FMtl/fy8mZrY4ts3CxxWPHhXg2YK1XYeNjqm
X-Talos-CUID: 9a23:HGG/4GwelZ8NuIWYr2QbBgUpKp4JQFT7/U3+JkWnJFdoUqe1UWWfrfY=
X-Talos-MUID: =?us-ascii?q?9a23=3AHTSPFA/NoTZFRPjzufPqSDyQf8Rq6KSuEU02rbw?=
 =?us-ascii?q?9u+PYDjJvHC+krw3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,225,1787011200"; 
   d="scan'208";a="59595381"
Received: from aer-l-core-06.cisco.com ([144.254.74.207])
  by aer-iport-6.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 21 Nov 2026 15:24:47 +0000
Received: from satishkh-l-mj0bbv6x.cisco.com (unknown [10.25.129.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by aer-l-core-06.cisco.com (Postfix) with ESMTPS id A4208180001DA;
	Sat, 21 Nov 2026 15:24:43 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Satish Kharat <satishkh@cisco.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Oliver Upton <oupton@kernel.org>,
	Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v2 5/6] KVM: Send reschedule IPIs instead of SMP function calls for non-waiting requests
Date: Sat, 21 Nov 2026 07:24:30 -0800
Message-ID: <20261121152434.955716-1-satishkh@cisco.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119235656.70315-6-seanjc@google.com>
References: <20261119235656.70315-1-seanjc@google.com> <20261119235656.70315-6-seanjc@google.com>
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
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.129.52];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.129.52, [10.25.129.52]
X-Outbound-Node: aer-l-core-06.cisco.com

On Thu, Nov 19, 2026 at 03:56:55PM -0800, Sean Christopherson wrote:
> When kicking multiple vCPUs for a non-waiting request, send a reschedule
> IPI to each vCPU instead of batching IPIs via a single SMP function call so
> that KVM can make non-waiting requests with IRQs disabled.
> 
> Avoiding SMP function calls for non-waiting requests fixes a potential
> deadlock if KVM VMX triggers KVM_REQ_UNBLOCK to all vCPUs when starting
> device assignmennt:
> 
>   WARNING: kernel/smp.c:943 at smp_call_function_many_cond
>     kvm_make_all_cpus_request [kvm]
>     kvm_arch_irq_bypass_add_producer [kvm]
>     __connect [irqbypass]
>     irq_bypass_register_producer [irqbypass]
>     vfio_msi_set_vector_signal [vfio_pci_core]

Thanks for picking this up. I reported the splat above, so I ran the series
against the workload that originally triggered it.

Setup:
 - Intel VT-d host (Cisco UCS C220 M7, Xeon Platinum), APICv and
   device-posted interrupts enabled.
 - Guest with a Cisco VIC (enic) VF assigned via VFIO.
 - KVM built from this series as modules and loaded against the running
   kernel (no reboot). To confirm the series itself does the work, my
   arch/x86/kvm/irq.c change was intentionally not applied.
 - Trigger: reload the guest's enic driver to re-arm the VF's MSI-X vectors
   while other vCPUs spin in guest mode, i.e.
     vfio_msi_set_vector_signal() -> irq_bypass_register_producer() ->
     kvm_arch_irq_bypass_add_producer() -> pi_start_bypass() ->
     kvm_make_all_cpus_request(KVM_REQ_UNBLOCK) with IRQs disabled.

Before/after, same trigger:
 - With a build that has neither my irq.c fix nor this series, the warning
   reproduces on the first cycle.
 - With this series applied, no warning across repeated reload cycles.
   Function tracing shows the bypass callback issuing reschedule IPIs
   (native_smp_send_reschedule) for the non-waiting request instead of
   reaching smp_call_function_many_cond(); waiting requests still use the
   batched SMP call with IRQs enabled. Bidirectional VF traffic (ICMP and
   TCP) and repeated driver reloads pass, lockdep stays enabled, and no new
   warnings appear.

irqfd_test, irq_test, vmx_posted_intr_test and smptest also pass with the
series applied.

This was Intel-only and module-against-running-kernel; I did not exercise
the arm64 KVM_IRQFD path, s390, or AMD, so the tag below is for the x86
VFIO / KVM_REQ_UNBLOCK path I can vouch for.

Tested-by: Satish Kharat <satishkh@cisco.com>

Test automation was LLM-assisted; all results were reviewed by me. Full
logs available on request.

Thanks,
Satish
