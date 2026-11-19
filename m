Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795048114;
	b=gNPA4p316to2Ik1rNewtnV+KXyaEO9KjPehORH7uVR5jGcSV5N9n9UhkDBeq2QDdLGmU
	 wxAeQRo0uGl6zwu3XkO+Pn6Bw0LdyNjvJEia+PLdFpEZVzf0BVaWAPd+m6SitZSoOBp86
	 ZtyTyQOCE6XvOC/WIc6l/daJ6L6e6gwjOqam1hKt87Q113Wt/DX8teW1+P2SHggxx/eFZ
	 g0atBRhP0GK2QpgYeZHQoJFc1IgsvfEZMv7TynGreTqsukp5SNeKGPMKQd1P8e7DtbTD6
	 HtB3ZEiN3nnPXedboD7y8d3f4NfYwnwei6Ic2hjxJtfJui77wbqBsJfm+eR5a1AYuyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795048114;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=Zq6Tqwoy13MDZMHyfOVXO/CSS1LCV1C4G1JBls7Zm14=;
	b=ci4hXSHvbhvDP3DG4A2dn8CqqynCIHXZ9uY+q7nmi8g76tqjLTK0HG3I1PH3DC0MGW5m
	 UeVv5ZGb+RdK8kikzCkmgoQCcEFNaBrJ/8TqyLHRY3/YNcJoAW4KrccmLE1Eol6+YgJQk
	 3B+8QTCZRDw+dSyBt431CzBBf6x2GJtZgPKuBhdtJUCqNfPL+0t23yiB9+3bQducyCFzu
	 huPMlNKn6zQpho04TRNFUnXhB1UXjHuHWHOQaVXF6R9dijw/IX8nykReDA8D5rFmGKK3L
	 hEQ1dEqmlZ5MEsvBrp2JsEegW/TgkSKXgZDxR7F1mQqUvW7ltWX4aBYpMNeL8vNugSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BOVg9qHA;
	arc=none smtp.remote-ip=209.85.160.70
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2018B606A320
	for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 00:28:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2018B606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BOVg9qHA
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-4a8eeb3386bso583416fac.0
        for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 16:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795048113; x=1795652913; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zq6Tqwoy13MDZMHyfOVXO/CSS1LCV1C4G1JBls7Zm14=;
        b=BOVg9qHAqYHj1JjipDuW3QnmDrR9M0cglgBDwp4lyFMAW+jOzsoGEykR/ITMvPJ25G
         1DQsBAMyVFKBrA9R3yJZ2pH2hSUk52OiTv+TH88N3Rg2Ulj1+AxXiG5X2NXU1D9BI+zp
         nV0J0KbwZeOnu4NhVblQ4kkJOfCdM4lYbUpFE2YLMlMAIaigYaaQWPN/7/4N51JoRkAv
         QF8YMtgz0CZTKlcXxF5zUGDdYa7e+2GtHWdWykKgTh/GF1ozmG0KY9Ha6KQTfv7Hx9T6
         ezu71WKQrY01Gf5OSXY4Om2oBjhk7TIM4+/18WusJdV4pYmvDYn5ch/Sqd0RYsV2XRcu
         QAWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795048113; x=1795652913;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Zq6Tqwoy13MDZMHyfOVXO/CSS1LCV1C4G1JBls7Zm14=;
        b=Q0yd/ipEEMSBjG86oNQ2U+Qk6Gjr97L6G4Nv+c2hVBG2k4FYN/ijW2tvkIG9557wyG
         wqG837PXdEgzA6LGOo/o8ODqoGV1BnH0CpIroWQZfIasTMxePHu7eylnM/6UDF/4C91J
         ljd8E2+wsGWACwW+xL7xvzZW59OlnjOKBHyBPre+24ucGzeHQd5InC6PNWwSuffArGmv
         lcQa5yJJSNusb41BzKTaI6Piujztt29ujtSGlYXXmoJz33RSCZfSiu+/nchTvBKCGqCs
         Ze0uWRrxHOFBhSzcPS3La1UCNcopEXOceW2vOrZcI3kinCu9hEb8aiLvugbwPJ/tpQs7
         fcyw==
X-Forwarded-Encrypted: i=1; AL+hErEMOL9hgwt3xeYMJpT0/pTC/5ZYaVVuB20aldHbjz/TzDFWp5v0BYEr5Z5JJrUmLL1vzfY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/2YSXNBOc8ltK+yqpsU2JigpuQzNMTV+FdWFOJ5mHjD/BLRycc
	1v3q7PsOnImnDJyaWrBELeAizfKhSBDwh+bn7uVnAM0lvrnkpg23MWF+Vb1tqcM5fpKXMJEfKBq
	pmha6nQ==
X-Received: from oaccw5.prod.google.com ([2002:a05:687c:2705:b0:4ad:bde3:7f14])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6871:4e93:b0:48f:a8b6:19d3
 with SMTP id 586e51a60fabf-4ba69ba5e90mr327034fac.2.1795048112768; Wed, 18
 Nov 2026 16:28:32 -0800 (PST)
Date: Wed, 18 Nov 2026 16:28:31 -0800
In-Reply-To: <20261118211152.3430478-1-satishkh@cisco.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261117205428.3717-1-seanjc@google.com> <20261118211152.3430478-1-satishkh@cisco.com>
Message-ID: <av5Crz-e2PaTNAjK@seanjc-mac.roam.internal>
Subject: Re: [PATCH] KVM: Send reschedule IPIs instead of SMP function calls
 for non-waiting requests
From: Sean Christopherson <seanjc@google.com>
To: Satish Kharat <satishkh@cisco.com>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Nov 18, 2026, Satish Kharat wrote:
> Hi Sean,
> 
> I tested this in place of my IRQ-bypass patch. The latter was reverted in
> the test source, and I loaded a kvm.ko built with your change against the
> running test kernel.
> 
> On an Intel UCS C220 M7, a four-vCPU guest used an ENIC VF through VFIO.
> With the other three vCPUs busy, reloading the guest VF driver traced
> vfio_msi_set_vector_signal() through vt_pi_start_bypass() to
> kvm_make_all_cpus_request() with local IRQs disabled. The trace then showed
> three reschedule IPIs from kvm_make_vcpu_request(), with no SMP function
> call in that callback and no warning. Posted-interrupt updates occurred.
> Three more VF reload cycles passed bidirectional traffic after VF traffic
> became ready.
> 
> On an Intel UCS C240 M6 with the same test kernel and patched kvm.ko,
> irqfd_test, irq_test, vmx_posted_intr_test and smptest passed. I restored
> the original KVM modules on both hosts after testing.
> 
> One source-review question: should the direct IPI path check
> cpu_online(cpu), as __kvm_vcpu_kick() does? The old batched helper filters
> offline CPUs, while x86 native_smp_send_reschedule() warns for one. A
> target vCPU could leave guest mode and its CPU could go offline between
> the request check and the IPI. I did not test CPU hotplug, and this would
> not imply a lost request.

Ugh, yeah, that WARN could be problematic.  Thanks much!

> Tested-by: Satish Kharat <satishkh@cisco.com>
> 
