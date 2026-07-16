Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231943A1688
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 17:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784222409; cv=pass; b=lohJX7Fx9RbsgxbQeAFIQO60Z8q5hYYH+PqW3CQDVWg8Z1dpw2VhRN6GEj3Oo5KfAk57SZh9CwJTD+g//FOVSwjpVbdCDGbaFC+kMXalt9Lda6Fh2hAde6/TSYsXh6i0OoWCIUM2mCx+7nZQ1wdSuR5lX6+R4in1lYC4QstOYNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784222409; c=relaxed/simple;
	bh=WgNPTyzJP6h+/loXvXxBK9obj+cvdvHP8r+IDx+BJ1I=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q+DZ3NBVnh4ctuQa2TLWPDqqatMh52zoQDO2M8tNX/iTK/wVa7m8s8RkEN8+DFqSMB4iXhRsS+oiYbrlAIE9hI9ApeJQOxAqy3X372KPdvuqipEntgqQ1inNRC3U5XoIDDtr5cUwx421zoT+OXjtMQMvYh5x+GwQrrsUhPdUz6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V5FFJtkQ; arc=pass smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V5FFJtkQ"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38dfe7eb825so3158868a91.0
        for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 10:20:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784222407; cv=none;
        d=google.com; s=arc-20260327;
        b=phYpm4l5WmBbIpuaUEXoBeAemNbWNkEZNW/xHq7P27AoHN3oBI2bwE/Q9hdLhoSFAu
         C3lZPREtfDqfxPOlF0VWgDb3DoqcWGMz2VdVZ8mn9gnKiIsMhtYKYLR/tX4Zx/9rIubh
         4QoWrp+0q6vvQnr8gdmFB3KYLmof7NvUA0HRWywH6akpNIOrXIHwE/N1gIW7EvwyxL7g
         ez6tkkEG/upD0r0hKy+v4fIudN1EcP5n/epFHQFlNdnDse7r3+m9TQ5W8AHbM35Xs8nC
         MyMJo22WQuX2LRDKbWrbB45HZr+PvTRyu3V1gFy8/SU6fiyn49xuUte4PnMPLscKEAFX
         5mnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=hDpH4vLaInenlGkSSwc32ERdxUXfDeJnyW2zrivGsV0=;
        fh=lyBIPy3TRRe/eqCg81GLlLguAt8lhjw7FdpY3NfGYzY=;
        b=FOaGT7g5TvsYrBLmu7eZNWLmbrGfP7LHLTNHFeDNC40RxEM2ce9K1/+DFKglJwtHun
         yhS2MWUyBT+RwO/nnAJTE6tNacR3Dj6UGexFKycfCAkkoVSU7kmjdSW8Qq3QRvY53Qse
         KV2DSsb4T/YhxougB7+kJ0JZFpoHlEwCNnpfsyoldACjbN04zADfdtEJFg5Re4/2aDPx
         aiquNnOXvatCKHl92vhk92zM0EyJaor7Bqi2+eCvRplklDI0nL4lh695LDzqeiaj3iHJ
         L8wciKPtZ4miFAd+2wNPaHO8/53gUuYooPegR/QeRAmUVls3Ys0fODU+uJVgjw7QA7Ms
         Pshg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784222407; x=1784827207; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hDpH4vLaInenlGkSSwc32ERdxUXfDeJnyW2zrivGsV0=;
        b=V5FFJtkQtJ5Of38LJ1sNYFN6lEt2zSeQlQhqKa7Eztd4arzlzvQYtO5vQms52mDfqW
         stQkSkmY79dewsm9D6RGU0g7NN2THOzuBAMSs0vUHPIpW/kDULG4x8kTaZLXeKjahtET
         hSmaCIzO/vzFMdUWrz9M44vrBs0Fv0XSLP8aSVWYsW+kxT7FnW9bu1b3++B73yUKKlEc
         IZWP4d8IXEcY8zl9qrszxW4PholUJthVAOkvtSrTXrwE/Am8Uxbsjau7q4gh199mfvg5
         PyD+eYQT890r3GNeGACnTDNovfBDuQrxrAcBNcpGGdx/yeSkTWLApNwfql7QSPVYJYfB
         7/cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784222407; x=1784827207;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hDpH4vLaInenlGkSSwc32ERdxUXfDeJnyW2zrivGsV0=;
        b=Gbwg4I+yMmBsxfTdhdl5iEpeh98ZORzGiHP61HvlfAsSnEAQJaIjAaW3zIsy5Dx3re
         GkV5KVRqam4MirmLXjwaFgr+PTdTFjnX52tNnTw0APc3WokAp6+9UWMM0JtoNtnrUNdh
         op+7PVPbE+q9dQHKmPOnfnMOLFzP5QVLr5jL9qUCeOWgdSsyrRQvTSMFAk0ycCMMDd32
         GJjRSGlnXXq2loEZpIWhyeVE+qxHlf1FuDxp1QIa4A4rM6J7s9hEBiNIWMIkguB20mEF
         CMc1RR/cNkDxSltCgeQ7IYKT7JbxmdAjqaFyn4qkVYyRe0UPbqgk1YliCAWJP9ObmwMC
         S2+g==
X-Forwarded-Encrypted: i=1; AHgh+Rp56Q5hegVZSICS+iEy/YGXFK3Fiv3taeBmhxNINCq2TrU9ydy7xnaudFTAciqTFPmnQ60=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv6vcSij67ARWr2Q8SwBBmg2gruyFj2qkf2u9AvT/ZrK8X+LYJ
	VrtayTPbkQ0nllz1+LFFxoCFVTsAoAekLTn6Ep1f5auUFpUtlhxtUydhf/i+rk+by3shZzXNpI3
	cun4/MAI6Fw2vLNqN+qQ/jK0FzveyaM1CkAQj8ivP
X-Gm-Gg: AfdE7cnxp81UaYqJZQIiiO+n3xhY1PEIho9dNZ6ZRQpDODPvEziAcm8PGlNXaswuFdR
	UTaAr/bqdzLkMLKXGuZtcnYxET3zAGBmgt7CuFswqg49oeUGthKYU7p3gEnZ7q5LQjlHQuic3NH
	9XbVLbJN4pf8P1kFNOanBScNy/tq9BTOWLtPudHNdIcXsemPKOFl6jbFj8sd3k6gknCveLfe0Vh
	DEvGTaWDNmHnO/naK3YlyrUctseDdO3hPwvpfo8SGbYZJALRoq7AfVCHyWY5ajpyJ7FwdvzaI1T
	mfWrwHsaIU3VU3Tnyz1wE+/KNBUo8ciK6TZhSN+yS+k6pO4Y
X-Received: by 2002:a05:6a21:7482:b0:3bf:6c08:2b2d with SMTP id
 adf61e73a8af0-3c3a5e7a4fdmr21247637.53.1784222406715; Thu, 16 Jul 2026
 10:20:06 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 16 Jul 2026 10:20:05 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 16 Jul 2026 10:20:05 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <1b59fec2-a464-4429-8532-880394912af5@linux.intel.com>
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-9-9d2959357853@google.com> <1b59fec2-a464-4429-8532-880394912af5@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 16 Jul 2026 10:20:05 -0700
X-Gm-Features: AUfX_mxBIq-fm92f37AIysrX2Jjvm6RrlF5jRh7Q3ctlrGsM_3yjDZToekOalgI
Message-ID: <CAEvNRgEjPA5pi1RqpQWgp_hH2HmSnGhWaNiXtVBJb_VVdKD7qg@mail.gmail.com>
Subject: Re: [PATCH v8 09/46] KVM: guest_memfd: Introduce function to check
 GFN private/shared status
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: aik@amd.com, andrew.jones@linux.dev, brauner@kernel.org, 
	chao.p.peng@linux.intel.com, david@kernel.org, jmattson@google.com, 
	jthoughton@google.com, michael.roth@amd.com, oupton@kernel.org, 
	pankaj.gupta@amd.com, qperret@google.com, rick.p.edgecombe@intel.com, 
	rientjes@google.com, shivankg@amd.com, steven.price@arm.com, tabba@google.com, 
	willy@infradead.org, wyihan@google.com, yan.y.zhao@intel.com, 
	forkloop@google.com, pratyush@kernel.org, suzuki.poulose@arm.com, 
	aneesh.kumar@kernel.org, liam@infradead.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Binbin Wu <binbin.wu@linux.intel.com> writes:

> On 6/19/2026 8:31 AM, Ackerley Tng via B4 Relay wrote:
>> From: Ackerley Tng <ackerleytng@google.com>
>>
>> Introduce function for KVM to check the private/shared status of guest
>            ^
> Nit:       a
>  > memory at a given GFN.
>>

For v9, I added the "a" in the commit messsage body but retained
"Introduce function" in the header (save characters, and make it sound
like a headline).

>>
>> [...snip...]
>>
