Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938923AFCF8
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 23:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785279972; cv=none; b=gF0lpJqPXeHphw7aO/XnBG39Ra1nXJsOrPdPouBimazb8NA5VxvWBKvT9x8yqW/WmLySlbhV5XSLqde30erNwpcbSjk9xVcVLCfMPLsQsB6YQNinVvED7l4tphmTOqw3vYK/UdY1MgZfiR80SnYRmNN6Mo7uUxUmhGVKVQDd1q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785279972; c=relaxed/simple;
	bh=DogBQgPNXswuGIoml9u4fiZ1siHOFMK0NYoj1Fcu0ek=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZgqNlDdrttJZ9eAcbwR3iKr4PTjHjVCFfccxB0kSWNYuhZ+ArUBwbDAUlVU+El+deqkRGl8Qx19Rs41KId8jmXvBsyJdXXd36llJWJ71PMc1nbQpQkatLRBPYSS1ROC6DwcEl7sQl0yU2RjXHdsMCOOKXVL29nL2LBOWUD56Ptw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XHnP7TLQ; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XHnP7TLQ"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84870e7f498so335923b3a.3
        for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 16:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785279971; x=1785884771; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kIqmps2dhv8tBsBvZD3H17qhoPMotCZtd+Geu7ae0Wc=;
        b=XHnP7TLQcqGrUbh4qia9Wr/2HZjShWsF0N076n1po6boeZ6UXtU2NtkpEbfbggHwZF
         sShCsohlVFZvoAywE37ZQARO2INQQyh6FJ9ptcxqFHHNtHMWK31Nk0eWQpMXS09abnDi
         YkLWtoWza6Kh6F24bcEqvsiAul5NaG4s7H7OaRYANI8ZBDjRqrPUxBjrl+rxGOeQ5qh9
         fzy0CwF1Slb7pivI5QShWDCnyQZfhwZRQCx5ya8S3MSVcYdt6ykHUo0h51zTFLBMRlW6
         V0gvIMOYEtvD0bkKD3TsRlMZp4oQ4pjnsqBVt40tuDBSSq9tQaEc0FoF2so/RnHLAMUl
         kGPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785279971; x=1785884771;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kIqmps2dhv8tBsBvZD3H17qhoPMotCZtd+Geu7ae0Wc=;
        b=U+aigrUJP7gfxVXi0rM2tVReeRrkuvdd8pxU1CXrF1BZMRkOjxuomcYwfLLScfYOea
         wNT3ylfoUKZbx16AjOg3ybkFgf90RqtZ7u6O4blNnC21JKLMXP0arM+5pj6A8OH+OqMP
         CliV4jxgz05ilpcg1IOF1/78SFtk3kBm3xZAF+1cZ/zhi9SkEPPmxq9GEu6kAFnV/Q3o
         lKE38bHvGt2q8fsdrGDDyIRFS3bnYDtsn6jDGAf8LKU6prpqG0j6d5YAbGQc+SZsySO6
         jZTuzWLEGyLE+nkIiY0WJBKe0uPyKcDPfFpvflR6Z4Ka7I8WpoX4wgbU4Uo5+smBcfpt
         LxLQ==
X-Forwarded-Encrypted: i=1; AHgh+Roa/79ajdvtY1L8wqadFIq3UOyxBSBd36fHVOLntB8xNWe2rfjfv5AFL++BouVhU0GngFA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw07a8gsPluEisZw6mAsvgk1lnXytAvQHCMKcoinwVlZ19oZ2Vc
	mhM6AALmQNiIlGKvBB9LMRKOfeVjJT1eWD90HJYvrIR5dvTZGjJfpCgwOklwZkLXVKnOvUnYIup
	QTDh9OQ==
X-Received: from pfbig10.prod.google.com ([2002:a05:6a00:8b8a:b0:848:478d:6efb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:8c5:b0:845:f107:38c8
 with SMTP id d2e1a72fcca58-84e9332e63bmr4750014b3a.47.1785279970563; Tue, 28
 Jul 2026 16:06:10 -0700 (PDT)
Date: Tue, 28 Jul 2026 16:06:09 -0700
In-Reply-To: <20260728144954.355376-6-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260728144954.355376-1-dwmw2@infradead.org> <20260728144954.355376-6-dwmw2@infradead.org>
Message-ID: <amk14dmn5j7Oov1B@google.com>
Subject: Re: [PATCH v7 05/36] KVM: x86: Fold __get_kvmclock() into get_kvmclock()
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Juergen Gross <jgross@suse.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Paul Durrant <paul@xen.org>, 
	Jonathan Cameron <jic23@kernel.org>, Sascha Bischoff <Sascha.Bischoff@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>, Jack Allister <jalliste@amazon.com>, 
	Dongli Zhang <dongli.zhang@oracle.com>, joe.jin@oracle.com, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	xen-devel@lists.xenproject.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Jul 28, 2026, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> There is no need for the separate __get_kvmclock() helper; just inline
> its body into get_kvmclock() within the seqcount retry loop.

Actually, there ends up being quite a bit of value if we rework the inner helper
to be all about the master clock mode.  If we go that route, then the main loop
is pretty self-explanatory, we can use early returns instead of continues and
subtle fall-throughs, and the indentation levels go down.

	do {
		data->flags = 0;

		seq = read_seqcount_begin(&ka->pvclock_sc);
		if (!__get_kvmclock_master_clock(kvm, data))
			data->clock = get_kvmclock_base_ns() + ka->kvmclock_offset;
	} while (read_seqcount_retry(&ka->pvclock_sc, seq));
