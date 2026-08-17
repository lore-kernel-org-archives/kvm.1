Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBB43AA4FA
	for <kvm@vger.kernel.org>; Mon, 17 Aug 2026 11:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786965968; cv=none; b=ZfkYOlmuB8w4zwcF7C5qQNxKyPfAw80yed1n/sEwLDLTHcgFgUI4wWWdoQRf+OzM7jFxAIvC5L0eUNq1sipYoR6142Qf6j0v3XHkf32rKnOfb+y3igja0LuwLMbX2YkfMAD/otrlTAIxK33HW6acFqkqjzpHxvGR4P7byYkeULQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786965968; c=relaxed/simple;
	bh=/HK3S1h/p4YqWHBgoSBiqiJ+ZmeGeH8/Mfh0HXbAKwg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FhCpiG/6y6vaJSOHt+WTZ124gGR2XokPA9lx1OZXhXEUTBC0CPP3hroULVO/tGLYNVmTin5QUlnhlLun3Yh2euhwke4kpbKYTD31zD+V8w1xI4ockAum61arblTwGAqnMy+13wROmKayhecLYlhfCvE9OxM00sW+twYLGE4H/44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mmunl2Kx; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DGtw6oqL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mmunl2Kx";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DGtw6oqL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786965965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q73ryK5kUwcmMiYglMvM52gIXR5G72fMcc+CsMgRAr8=;
	b=Mmunl2KxHzXGJDwdYKYHKgtHDOq1qJv/x0W+7RNbuj1Vg8yfu9OnV51Eguo9CjApLSemw0
	IEF6nSqsTYg6nTq+dm85MYmUYoGEYDXGF2E4XywgXAq8AIYoRtERsStNj7EOLbUEa8N0VA
	nO76zZeqrcJYAf2t0X6G9Cp8fJMxOks=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-9i-tQrPFOberOAZq9im4kw-1; Mon, 17 Aug 2026 07:26:04 -0400
X-MC-Unique: 9i-tQrPFOberOAZq9im4kw-1
X-Mimecast-MFC-AGG-ID: 9i-tQrPFOberOAZq9im4kw_1786965963
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-496b61bd846so23007935e9.2
        for <kvm@vger.kernel.org>; Mon, 17 Aug 2026 04:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786965963; x=1787570763; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q73ryK5kUwcmMiYglMvM52gIXR5G72fMcc+CsMgRAr8=;
        b=DGtw6oqLmzPT2OpXLzu1CojnIG5mTW/Tpz3EcFQb3LRbZqnzv8qhoDD420kKfMKidV
         nfuLEz0QI6JxYbvKzhIi/pJBXIODmQP4J3yPwyHg0K2nqRllKoX+snaRRNRiBonsEAwy
         EkzPVh1HWdnw/E6C/ZR+q+PMy1u/5hpuS0QvK4Ofb+5qBoMU5nXThv8L3IEFmmNmDRqs
         jjXkUkW9XP9Opu3jphCYK9k0gqjESdOK7CsrXU1E5GkBWdV4itwWjyBT55bY9Zv1/T4h
         d7r9QC/a6/mCMZrqcrClMzqhvEN42G+CBT9SJH5bGVH53vAKJ4h7ysC4UOmkg7zZyjWA
         EYeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786965963; x=1787570763;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q73ryK5kUwcmMiYglMvM52gIXR5G72fMcc+CsMgRAr8=;
        b=pKgl5S8kK32iUaPz4wwaGQVPQ7MNOjPshHLJhC6TVVKA5jRkBPu4GUvaBvHOzitKUk
         3OuPyhEVz5RLZAesPl4A9Cm0zLVpeP3z3qq+5naB6/SJ4FWlfV4evUXtRGJD7zTZvCCb
         f9ZwepNKaDwV8xqz6U6jF+pCq0D2c2+CoL06iF9C/WmWFm65NDTOqS8OtjTj1fGjcPGn
         6EW67WLqwGm8suy0OXMxOiXRMv/RE4YgYvHE6WvNG1WVx0AO+JijSaJwrFQPdvRrTDJC
         2K71Kf0EW3JXVjDStrcdU30Z5PP8X/J5v/UaJOqapTXCcFqtPPGqlO43e5qZ7BWUHQnK
         xfmA==
X-Gm-Message-State: AOJu0YxbFlyIkrKdW5P5Z+Tds9rrbjB/walUuOdfTEY7qOjCiJwKxppb
	uIPvAVym6QmtF1au7D9PsZGKXzbaywbPj7iOGTMNKyn7KJK55ZKzTScUzmXyAFI5IIQp9D8tupO
	G/X26wLnnqgj+DF/WxRzlZxsuzumWOHoI6WaT0kTkRyU+3woBeGLvaMfPGr67DNcNUDyvMvWC+6
	b6xoc4MsNhaWgX9q0eYnltMoivA1yhaft5zCXkCw==
X-Gm-Gg: AR+sD12KnLdfNk/rhaA3wTh0icAlkPTfgjeOESJUHuI68k+gEdNOTBVMvZZPUXdarq8
	cxAbtGMnDhg3ukBaazHRQt16jjAxu8dqHavSPKbsxIjeqcBaE9ncoyqZIo1RJBRdOgysNjP/63P
	CoHZcOeeGUPbgUWsVZOj5NAGLOtU54xO6mfRazw++nSEmj/TxvnPwYf/UestNqtLpTFoaFxyU+i
	lGGznApJNQZQW/4nE74lynUNzGOtmWcvb3yiNXE9dJm0yDCngtcrdPImDP0a8clIYvbWpcbr4CJ
	gIGWB7fTu+p8Zn/Mt++RB5IxB6QH2TuxCSAArEVVosOnNn/WjZ8eRS+Dp4pUE0Hvl841c5CgHxK
	S1A==
X-Received: by 2002:a05:600c:468e:b0:495:6a50:3fb8 with SMTP id 5b1f17b1804b1-49987944202mr342126715e9.1.1786965963273;
        Mon, 17 Aug 2026 04:26:03 -0700 (PDT)
X-Received: by 2002:a05:600c:468e:b0:495:6a50:3fb8 with SMTP id 5b1f17b1804b1-49987944202mr342125905e9.1.1786965962850;
        Mon, 17 Aug 2026 04:26:02 -0700 (PDT)
Received: from fedora (nat-20.ign.cz. [91.219.240.20])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a6c449dbsm2091445f8f.8.2026.08.17.04.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 04:26:02 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: sashiko-reviews@lists.linux.dev, Sean Christopherson
 <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
Subject: Re: [PATCH 4/4] KVM: selftests: Check VMPTRLD with active eVMCS
In-Reply-To: <20260814163105.BDEC31F000E9@smtp.kernel.org>
References: <20260814162221.2144473-1-vkuznets@redhat.com>
 <20260814162221.2144473-5-vkuznets@redhat.com>
 <20260814163105.BDEC31F000E9@smtp.kernel.org>
Date: Mon, 17 Aug 2026 13:26:01 +0200
Message-ID: <87lda5kmye.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

sashiko-bot@kernel.org writes:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The hardcoded `VMPTRLD_INSN_SIZE` of 5 bytes is brittle
> because `vmptrld` is executed using an inline assembly memory operand
> constraint (`"m"`), which results in a variable-sized instruction
> depending on compiler optimizations and register allocation.

True that, but afair we don't currently have an instruction decoder in
selftests. I see three ways to move forward:

- Calculate the size of the instruction with two labels, something like
  (untested):

    static inline int __vmptrld(u64 vmcs_pa, int *insn_size)
    {
            u8 ret;

            __asm__ __volatile__ ("movl $(2f-1f), %[size];"
                                  "1: vmptrld %[pa]; 2:"
                                  "setna %[ret]"
                    : [ret]"=rm"(ret), [size]"=m"(*insn_size)
                    : [pa]"m"(vmcs_pa)
                    : "cc", "memory");

            return ret;
    }

  and use insn_size in the tests.

- Stuf __vmptrld() with NOPs after vmptrld and keep the constant jump,
  just make it loner (e.g. 10 bytes should realistically be enough).

- Make peace with the fragility (it's just a selftest after all) and
  leave a comment in vmptrld() that changing the asm there make break
  the assumption.

Any preferences? Personally, I'm feeling adventurous and can go with the
first one - calculating the exact size with labels.

-- 
Vitaly

