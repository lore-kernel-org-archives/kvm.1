Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647152DCBF8
	for <kvm@vger.kernel.org>; Thu,  9 Apr 2026 17:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775756199; cv=none; b=sqPZcJamnuhB0z/1xOVecvTNB8Oir3WUhGY7ETp/jTSTTBLS/Tb8iwv8fWj4thTAJk3thlWKIoZy7KCApUgQv6Et6Et9+TQ1IuuzqNPLQZNSM8pWqNLaj+v3VYrMTRXFJYO5UzGLmtgwgffhq7WOnnyNXrnVLSIqD1II0+N7y4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775756199; c=relaxed/simple;
	bh=/nFp3H1jvzcz3wzZQIK+M0rRkKvkk739gDNT6ihiLsA=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=Jm3Q2SjNOuO6760nmZ+E/TMB3W3HxEHGU3YqUH7R+OpT5Pr5ax8lVOuUTvScPJ4OMSxQ8mZWu22WRz5vv+hcrzzuJ3EJI9kb9yjYnrckIq8t8gqE18KM+5o6VsU7RE+UZsaCnU4DZPhsi0Bgji/P/jTQal+JnQOtH6CGnoIH+6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LSVMjyHI; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LSVMjyHI"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488c21c636dso7018065e9.2
        for <kvm@vger.kernel.org>; Thu, 09 Apr 2026 10:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775756197; x=1776360997; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VikJJNd5VhOwaHnCnCCu6joDVLiO8EzhNeusI2Ghpa8=;
        b=LSVMjyHIR8G+niZA8P9b2AMes/mYV3bebY8+Lfkze0SKT9zvt7ZbVDgiNNNPvXE4JC
         jtptQgc6tDB9pRma1QE/0nA7MEr1+DZAydQSkrOakHB2zdp8l1/0Avvx9YT5ZgEtxK8p
         68FH7awfLKypUe29Z7vf297WrNQNsAblbJNK9zDK/lCEbnJcgZmrWu8bT3P8/B1KwDoD
         a6KUdbRUTfTqlDsEviYgZcyR+8s65MTLfXruz68VVr8aTLLrfnb07A3TsSyS8lN1L6RS
         1KfvGFnhV0VYXMw2REFQR1stUhkz7Nvr+c0FeUqz8g3Zf1WuIBRmvaGbF4gSlUFmg/aY
         TE5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775756197; x=1776360997;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VikJJNd5VhOwaHnCnCCu6joDVLiO8EzhNeusI2Ghpa8=;
        b=m2bNgQFrAO+rw0Ya2rG72VpePr105+lOXC+5N04nTovPNQG2OTp3WYMaZ3hmodroTB
         6uIqlfJtpF7QbrB6JLMHBd5PPlZ/wIXwgpMloZlQ+U8avDglj53H3F3Oh3A1Nll4BrOQ
         clqzl2OTedH2WqIuNLcU2fYHQFhtImGPP72hY8/FhpqVYc504WiVEGmtCnxIPcS8wTU+
         NHScDmj6UhG8C7AvBxeswy+QFYFoUokSnCJ4bzBmUZqknEsnHd/122UP7KxubTN6BiQP
         sRbMmblpaE8rqnwuBMVXoh7eu21G/azgsAoJhu5dByzKtoDfYyDviUyKD6C+2/xTKjbx
         dL5A==
X-Forwarded-Encrypted: i=1; AJvYcCWBOzYuQcFpxxMFkymIcCWNQpktLvgdops5ro4eM2HraM2i5Rb7AuKExVnswvjqAMGsaLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB7NI2vbJPZqzoIDWziwZTCZU4qzrKy33c/CqsR9ZJRo41D/Hp
	x6IN7QjSSlGEPgTgY264IkIzHf5yuz2RLubHyIMWPBxkUeoRkGwDnTFZ
X-Gm-Gg: AeBDieuBqo8q7jdeLWZyPr3P8M/b+kBtzvLiLbuFKtnC9xZr39gTC3gOmKEwWqMPdFV
	BBpwwFn1kAe+sd+nAOucopv6IF6rmpXHXD1CqPB+bqrSAMaWu/IG10YDdxKTjhqoW/ISQn9QyCt
	9fRnDumzXOkUvGbTkWexEyMdyht6JcFyQwyZz6Cdu1vqeCOMhGi+VOgRFoSO/MWXkxGgNSFSMy4
	uTfWkYYnufYmTy3JdnumrLjtRXezTddMRRNSdyQ5LZwvSqIH05kaOvWiYmpF3VE4dWj6c9pewP3
	iEyYkQ3GwbGTNecA4RUMrgrEUThs6gNsMsadSUS4/dWLcmnfBrZYTGsmJ4UHTYgem/eVHN7v+kc
	uGOTrebxafMSDpPwexEF/hQPfCDXTZy2nliawY6KG2cpUQ2hm+mapjj1dRpIRim8rwfBl3aZ/wT
	UnOiKy6pq3My9KE+O/cYlPlqdQt5JI80YF68gROYMBWAcAy9N1nr/K9ayvcqvwq9sKUC/VNVxpB
	JY4nZ+bHbsNGtYYZwXI6xeWkRYQheDXYVV+PESSkR7etRsZ92UyWqtW
X-Received: by 2002:a05:600c:3f0a:b0:487:2439:b7c8 with SMTP id 5b1f17b1804b1-488996a206dmr383393495e9.1.1775756196592;
        Thu, 09 Apr 2026 10:36:36 -0700 (PDT)
Received: from [192.168.1.100] ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d58a414bsm6710175e9.4.2026.04.09.10.36.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 10:36:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------REQjjt0ep03aOgQcIyxRW5f2"
Message-ID: <57796f12-53f7-426b-be4c-abf0b2ce2061@gmail.com>
Date: Thu, 9 Apr 2026 19:36:34 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] KVM: VMX: replace vmx_spec_ctrl_restore_host with
 RESTORE_HOST_SPEC_CTRL_BODY
To: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org
Cc: seanjc@google.com, chang.seok.bae@intel.com
References: <20260408182213.522713-1-pbonzini@redhat.com>
 <20260408182213.522713-8-pbonzini@redhat.com>
Content-Language: en-US
From: Uros Bizjak <ubizjak@gmail.com>
In-Reply-To: <20260408182213.522713-8-pbonzini@redhat.com>

This is a multi-part message in MIME format.
--------------REQjjt0ep03aOgQcIyxRW5f2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/8/26 20:22, Paolo Bonzini wrote:
> Reuse the same assembly as SVM, just with alternatives instead
> of cpu_feature_enabled(X86_FEATURE_KERNEL_IBRS).
> 
> Due to the dearth of registers in 32-bit x86, save/restore %eax
> across the restoring sequence, keeping it simple; the main alternative
> would be to leave vmx and flags on the stack, avoiding the need to read
> flags from %ebx.  It's not really measurable difference.

You don't need to save/restore %eax. Considering that
RESTORE_HOST_SPEC_CTRL_BODY doesn't touch %ebx, and that

testl $KVM_ENTER_SAVE_SPEC_CTRL, \enter_flags

is placed at the beginning of the macro, you can put @flags into %eax:

+ pop %_ASM_AX /* @flags */
+ pop %_ASM_DI /* @vmx */
+
+        /* Clobbers RAX, RCX, RDX, RSI.  */
+ ALTERNATIVE "jmp .Lspec_ctrl_host_done", "", X86_FEATURE_MSR_SPEC_CTRL
+ RESTORE_HOST_SPEC_CTRL_BODY VMX_spec_ctrl(%_ASM_DI), %eax,
.Lspec_ctrl_host_done
+.Lspec_ctrl_host_done:
+
+ CLEAR_BRANCH_HISTORY_VMEXIT

The above macro will clobber %eax via clear_bhb_loop(), so you should leave:

   /* Put return value in AX */
   mov %_ASM_BX, %_ASM_AX

after it, like in the attached (partial) patch.

BR,
Uros.
--------------REQjjt0ep03aOgQcIyxRW5f2
Content-Type: text/plain; charset=UTF-8; name="vmx.diff.txt"
Content-Disposition: attachment; filename="vmx.diff.txt"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2t2bS92bXgvdm1lbnRlci5TIGIvYXJjaC94ODYva3Zt
L3ZteC92bWVudGVyLlMKaW5kZXggNDQyNmQzNDgxMWZjLi5iNzA3ZWJmNmU3YTUgMTAwNjQ0
Ci0tLSBhL2FyY2gveDg2L2t2bS92bXgvdm1lbnRlci5TCisrKyBiL2FyY2gveDg2L2t2bS92
bXgvdm1lbnRlci5TCkBAIC0yODYsMTAgKzI4NiwxMyBAQCBTWU1fSU5ORVJfTEFCRUxfQUxJ
R04odm14X3ZtZXhpdCwgU1lNX0xfR0xPQkFMKQogCUZJTExfUkVUVVJOX0JVRkZFUiAlX0FT
TV9DWCwgUlNCX0NMRUFSX0xPT1BTLCBYODZfRkVBVFVSRV9SU0JfVk1FWElULFwKIAkJCSAg
IFg4Nl9GRUFUVVJFX1JTQl9WTUVYSVRfTElURQogCi0JcG9wICVfQVNNX0FSRzIJLyogQGZs
YWdzICovCi0JcG9wICVfQVNNX0FSRzEJLyogQHZteCAqLworCXBvcCAlX0FTTV9BWAkvKiBA
ZmxhZ3MgKi8KKwlwb3AgJV9BU01fREkJLyogQHZteCAqLwogCi0JY2FsbCB2bXhfc3BlY19j
dHJsX3Jlc3RvcmVfaG9zdAorCS8qIENsb2JiZXJzIFJBWCwgUkNYLCBSRFgsIFJTSS4gICov
CisJQUxURVJOQVRJVkUgImptcCAuTHNwZWNfY3RybF9ob3N0X2RvbmUiLCAiIiwgWDg2X0ZF
QVRVUkVfTVNSX1NQRUNfQ1RSTAorCVJFU1RPUkVfSE9TVF9TUEVDX0NUUkxfQk9EWSBWTVhf
c3BlY19jdHJsKCVfQVNNX0RJKSwgJWVheCwgLkxzcGVjX2N0cmxfaG9zdF9kb25lCisuTHNw
ZWNfY3RybF9ob3N0X2RvbmU6CiAKIAlDTEVBUl9CUkFOQ0hfSElTVE9SWV9WTUVYSVQKIAo=


--------------REQjjt0ep03aOgQcIyxRW5f2--
