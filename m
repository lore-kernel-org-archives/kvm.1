Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794589843;
	b=yE12kaDJBhBV+yuY+bM7CKqFrT1YN3xv+x6hTLaw1AWmYl1Ug7SJ0TQ+RKMTu+FRxFer
	 rXw4hVTJgjTTP9aLYuAV00LwyRx9N8BKa+E0CZFVrcxAy/kfCUhcHJEYzhk9pbeuhT8mF
	 TZG0quhuIcSzAzlz0EzGYDyn8Ov+b5v8hwU49QhplRNOPXizaWoHd3AZHXqqaKk+Yq3Y7
	 zRGNnW1r3gXQ400BbjxPFQ7OvyocBEnUI93CHaXwtWIqu4+vlHa/Kvr0GHVvrEqBRcnnq
	 CkQeaGs6bh35gxdS7xvPejFD1kOvaiys5T9RPAtJanlZnwEp1hXyGdOHUn1Lpi2cSJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794589843;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=E0HYZnvoFY2cqYeGKLL4I6ESGkmMzyISge4rNBKOPnQ=;
	b=qrin8Gl+pwZBlpGci67C8VqH/8/dJ/dfN0pvh0hUnzZ8/n3rgooJSiFpm/Mo5yEPNlLg
	 hiHs4HKLAKPphKe3xA/1gFF4spzC8W4XDQE9s51ye+abOsu665Wg6Kv8AjqMyo18I4eCc
	 ESg9Ke+QIi119wnDhqrRus5BKnwJvd2wK6tAdTxZMio1c9OzL01RD6TRFxzTbHi9l+KDT
	 ksdGxZy+VbUy3FZOtATRpk8roM3G6AjAdhGZPIzPbGiwH/DBi9zncSsbSrk51nigvmcy5
	 TbhxEGc6t2A5EaozsykS1GU7N1J0QSMFmP4RXKeD6uh6k54jQuEjjkApcDWEfgQZA0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Ajpn1FZU;
	arc=none smtp.remote-ip=209.85.215.197
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C32B606A327
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 17:10:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C32B606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Ajpn1FZU
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc73895c7d5so1294951a12.1
        for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 09:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794589842; x=1795194642; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E0HYZnvoFY2cqYeGKLL4I6ESGkmMzyISge4rNBKOPnQ=;
        b=Ajpn1FZUD6fdphGL4f5vUwF219i7l5zDYRSDn5qpvopjTucfLpwhBi+V32T8AvbkT8
         RWsRiKmQHMtZ0Y4DXyBIIzisa4aOm9Kpqn6zXnFueVRXAfSBqYFfjwXDeU+cneX/ZUV5
         HefkxbOejcUXxKGiEy7KSwSP4IBU4fi/pKYMHUBYcv1mvmdQpwDaw3KHI/5S1lKhvGqr
         Aqh8AaNox3wkrdcHJzrvSIPrPnnwYPqODX7othykMRmXizjKVDeUsrh370Tsh+29iDXB
         +uM/wdIJpMXmJ6KUDCozEHrN42Uj0kEx3LPWxPBB1gb3KlpwfgJe+HUqqMPUhgl2ikGU
         KuGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794589842; x=1795194642;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E0HYZnvoFY2cqYeGKLL4I6ESGkmMzyISge4rNBKOPnQ=;
        b=wA3RmQeUad3IVI4W7iJoVD5Og1pqwD16Un6lFPxqWnlpMlqY3/UWeiu/YqHF3ysrtC
         3jhHAmCcTpgVvMiP7TLVyufNXChFQb9vsmAktP1Au+5oVEJNEOa4M4qC5FvfN9muhXVC
         9YpsJ4LsyvVH/naLkMwiy/RZvNapWnw9HM4hm71nGLDXchFzHFhs7XYBlK+PclMU5NEy
         j5dCV5iq0ZY4ew4q8hoovMbah4hO0G6SmYzzsKAU/F0/FgRMzhXQ4Fu5IiG2GfVSRqbG
         kRW8JFH4+RFnvIp0bh7fzo07vYgFpavH1vRnXb6xoKzjcmcm7w/pWkqd0OWpKjPY5GHg
         pXSQ==
X-Gm-Message-State: APuU4Z8DwjS0RaGeqirn8RSvMCXBuBjw9rqJBW29Z3YUHEGUy24iLhW2
	XKoJxVgK/5kuUS/bBGB5jJArUac01HYanWXunBZzcKjN1LlrK+F8aHZyJ9tqPp6pw1IyJQN0Y02
	nu6b2Sw==
X-Received: from pgbda3.prod.google.com ([2002:a05:6a02:2383:b0:cc7:dd4c:a852])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a10:b0:3d3:ae50:97ce
 with SMTP id adf61e73a8af0-3f7a7bc23c1mr3448497637.27.1794589841765; Fri, 13
 Nov 2026 09:10:41 -0800 (PST)
Date: Fri, 13 Nov 2026 09:10:40 -0800
In-Reply-To: <20261113170535.79246-1-dwmw2@infradead.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113170535.79246-1-dwmw2@infradead.org>
Message-ID: <avdEkNbqPWamMErl@google.com>
Subject: Re: [PATCH v2 0/4] KVM: x86: hyper-v: Forward unimplemented
 hypercalls to userspace
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Thara Gopinath <tgopinath@linux.microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Michael Kelley <mhklinux@outlook.com>, Nicolas Saenz Julienne <nsaenz@amazon.com>, 
	Nikolas Wipper <nik.wipper@gmx.de>, Mushahid Hussain <hmushi@amazon.co.uk>, 
	Sriram Nambakam <snambakam@linux.microsoft.com>, Zack Rusin <zack.rusin@broadcom.com>, 
	Doug Covelli <doug.covelli@broadcom.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, 
	Shuah Khan <shuah@kernel.org>, Paul Durrant <paul@xen.org>, Xin Li <xin@zytor.com>, 
	Francesco Lavra <flavra@baylibre.com>, 
	"Radim =?utf-8?B?S3LEjW3DocWZ?=" <rkrcmar@ventanamicro.com>, Liran Alon <liran.alon@oracle.com>, 
	Arbel Moshe <arbel.moshe@oracle.com>, David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="us-ascii"

On Fri, Nov 13, 2026, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> KVM implements a fixed set of Hyper-V hypercalls and fails every other
> code with HV_STATUS_INVALID_HYPERCALL_CODE. A VMM that wants to
> implement more of the TLFS, such as the VSM hypercalls Windows uses for
> Virtualization Based Security, never sees them.
> 
> This series adds KVM_CAP_HYPERV_FORWARD_HCALL. As with KVM_CAP_XEN_HVM
> and KVM_CAP_EXIT_HYPERCALL, KVM_CHECK_EXTENSION returns a bitmask of
> features and KVM_ENABLE_CAP takes the subset to enable, rejecting any
> bit the kernel does not report. The first feature,
> KVM_HYPERV_HCALL_FORWARD_UNKNOWN, sends the hypercalls KVM does not
> implement, and extended hypercalls in fast form, out through the
> existing KVM_EXIT_HYPERV_HCALL exit, whose format does not change at
> all.

I'm not a fan of fowarding unknown hypercalls.  It seems like it would be quite
easy to end up with a mess where it's difficult for KVM to implement "native"
support without breaking userspace.

How much code (and ongoing churn) would it be to add an allowlist of hypercalls
to forward to userspace?  And then obviously require userspace to configure its
forwarding "intercepts".
