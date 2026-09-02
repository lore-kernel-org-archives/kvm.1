Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC74247DD4B
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 12:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788351684; cv=none; b=Z8JE/vE0pN4B3jcFC9ile8ADQAPjj54nTinK0UjaBDwDqGxp7rGYTczwx4ZGQIYGhfwdXGfZNMKRWK4nS4/B02dWie0dTSugrw7jf0StYp1kx7445kfcriBza3U+zaJSqxqf8QPJw5hC1TAi1nW3SiVyjpwoMU7/UAJIDGWTRYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788351684; c=relaxed/simple;
	bh=9fqEfRKgUMJWyOe5ZNAMkjiVee0f/Gw/F2S06frt78Q=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=qvQbbt9uiB8DiNvr9x52/9UaeGUdg7yXrltSMG3UuHmLL/Fj/6DZex3L+4gd7EyGSW9741FoBVf27nT/MS7wOcoTXpNB4FmqVqEHuwzhzTOf6F1gUmJt7iOM5TGgs7iJswvv/dX8jc2YD+X+jb9uvtu6cZQVV8+1zLvHe6mTK9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qs0v8pf8; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qs0v8pf8"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6a682579c72so1258479a12.1
        for <kvm@vger.kernel.org>; Wed, 02 Sep 2026 05:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788351681; x=1788956481; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+YtppFXPJvnaOnAk6ks95iIPAquAZkAVzmmLnfe8b94=;
        b=Qs0v8pf8GFPWB4JsWj0ZkMouJUGDOCg/wKdVq5zefebovi4tGw6h7mhPtBbjraeneU
         WYJ3VvvIMYtHhbs5ZtixVdQGSODSaymWQRSPRkukMdlDOGTWt7v+TyAPYiT9V5gxF1TO
         HhGivD+/0S3GgYpvcEXHbV72AodsWGZDe5+53xy7mdLS2GpX9UBmY7xFmvlp8jQ9fiZq
         iAqkHrX8G93YNbT3EMpAsNTVRRE8re4J+Fj5fCYzlDyx9WMJcZ8zy/8N2x+/Yg3w/i1o
         soTlP8Sb/LhuM0Uqm+/TY8uY4ED1/PhTsgi3WVe/8u87DQ+B4WtcfmbQb8MMBMURq+d+
         bblA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788351681; x=1788956481;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+YtppFXPJvnaOnAk6ks95iIPAquAZkAVzmmLnfe8b94=;
        b=LO/o6GbUmfwBUQwDdu0zXEBP+1bXKzOB2eVR9ehtZidfH4CvRrhvuN5jd56J1Lunmv
         HpLW2zKxJiQPziRnfY+UL6bYvTPQtj1zQBK4Q6zJd6k6azmn3suVdGbL1gAqtbEtQiAm
         yGUFfBUljXYsq53CMMXnaHBdXNUzujnQcqRRmyJJBgwsXK8ZbYRnvFIDJnpspvose9rK
         yD4y1H955EaDip1nZE8tI8Juqt64CWUoDNiTNIzcNq6EzdJ0pZRfVgapGJsRoLjBHMA1
         UFH5dAdhlf2Dn0RJKsHPMlsxreFTUSJorwLdZ7PuqZuNe4d0mOrr43UjyODOWZs6auOK
         Td/w==
X-Forwarded-Encrypted: i=1; AKwUvBwYPzvnNZxnjMp56p7PmHeDExr1O/zU7YZyotwN6ciaNhBkJbu89md0Oiy8Mjlnqq1iVjo=@vger.kernel.org
X-Gm-Message-State: AFuF++lWZVj9ZFo1ifcmzoXMb6lsRLn3gYX7xkGmdUAmloQCY8fRzUkx
	ZcOg8s0KjtdcNxK8efYzOJYQ1HJd96hZ5QcdRaxdPD87jGhR1Dcpemqp
X-Gm-Gg: AYBFou20B2drOgvgJjVp5JIAR8LXXEfxIU2qr2AvKzvkxutD1deU2LxQfhTnzPYS7Wj
	IVBDRHZ9xh8UedOi++BIFGYbkjpVPiRZ5yIOiPtGIBXpqNCkdHCXHKVwdCibxuY6Ff4Xtg+SaMU
	FHeJN2HqOsDbfwIkKyuurAzNrllxLUEICWCd+FBfpPwt5NvBqaa7Tt6fKJqZKnjNZd/Moh9bH2h
	A9/TWzJg/wFDc65IX95H0D+5eG6lrom0HXugQrJAcaGPOjKSI5d4f7MOrnmAHo0PyXwWMKJJsS9
	++v1u2P4pPvKtyniicj30Ebx+1+6hwaId95VRmPi0u/ugCSItjzqIRKVmRVRdu6+dQj9vW6P/Rc
	OdtC4fgJ036wuE1Kqn+nutDmeAWqecfqdZ+I1bm1AwsZBGdDSEn3pb9nuHFOVJtlBREDWNm1Q4L
	WHMBY3X5jmKv8d9EAlXj2jpI8eTrV+7XNAPBVFP/+Lfy4poty4a+5pOLpsQIXr2rBn
X-Received: by 2002:a17:907:3d49:b0:c25:c7a9:7b8a with SMTP id a640c23a62f3a-c25d54b6d03mr288409066b.12.1788351680630;
        Wed, 02 Sep 2026 05:21:20 -0700 (PDT)
Received: from [10.45.18.37] ([15.248.3.93])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25d03f4d39sm123342066b.47.2026.09.02.05.21.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 05:21:20 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <d5d6a854-bdaa-4d69-87d1-c7a1731e8690@xen.org>
Date: Wed, 2 Sep 2026 13:21:18 +0100
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/13] KVM: x86/xen: Introduce
 kvm_xen_has_64bit_shinfo() macro
To: David Woodhouse <dwmw2@infradead.org>, seanjc@google.com,
 pbonzini@redhat.com
Cc: joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
 ankur.a.arora@oracle.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, x86@kernel.org,
 syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com, suryasaimadhu369@gmail.com, lkp@intel.com,
 nicoyip.dev@gmail.com, frn1furkan10@gmail.com, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, imv4bel@gmail.com
References: <20260831213632.81023-1-dwmw2@infradead.org>
 <20260831213632.81023-3-dwmw2@infradead.org>
Content-Language: en-US
In-Reply-To: <20260831213632.81023-3-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31/08/2026 22:26, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> Add a kvm_xen_has_64bit_shinfo() helper macro to replace the repeated
> pattern of 'IS_ENABLED(CONFIG_64BIT) && kvm->arch.xen.long_mode'
> throughout the Xen emulation code. The macro uses READ_ONCE() to
> ensure a consistent snapshot of the flag, which can be changed by
> another vCPU at any time.
> 
> This is the KVM equivalent of Xen's !has_32bit_shinfo().
> 
> Assisted-by: Kiro:claude-opus-4.6-1m
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   arch/x86/kvm/xen.c | 16 ++++++++--------
>   arch/x86/kvm/xen.h |  5 +++++
>   2 files changed, 13 insertions(+), 8 deletions(-)
> 
Reviewed-by: Paul Durrant <paul@xen.org>

...although adding kvm_xen_has_32bit_shinfo() for consistency with Xen 
might be slightly neater.
