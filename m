Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792501490;
	b=mlK2/qG24tEiwWDq1QvAwXlwsxCAkuG9sNOOZLzoScjBNlGkhJHEaC33HuAQDh63Wd8k
	 D+JjN6d9BNqfKqaPqEY52QcHgwvMfn/cIMZmVJMiAwhZNPvbUIFJRMlf1BTHKmL6viDwH
	 T30CZrUArVCKQ6ObChnNaYmVPbtRXGdHM0/gnO1C3N5azIngsVheJEkaGPh7BNc3K05g+
	 0sb9Kre/3KdJMu5WHYnBWphKVkHHG+z6WZ5rJ/Dl18MeCmLgEfWIi6Rlk6JnsDyc55k2P
	 IDM81Ku2xORBTLx1buKiZmWWabrFMB9Qxf3Gx4A221LUwNa6X/7pMInXoubCSbhKz0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792501490;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=TiOSNZMdnqqChU7eCmFOfWFFqcm5VOjZEu4im1R13jg=;
	b=pPIOXRkjd3EsaEFfz9asFhqdoyL/6GUUT+AqDCG+VUYseYGCYoxCntTDlCXIyR3+NWz2
	 x0HIbh3aMjRw4OEktO5mlu5xqZsI0KfHOrPHCX9nxRgC2/DQh6Clq9NOx+mtnU2j79D5D
	 V0gCZBbO7CA3INOeqyBmNF42JsdI9hdQQ1j+FYXqkLKYwgroO7tJWvteWlnnl5xcbBvhb
	 YJjf88Zff5GdhHJJyhHW9I4mjJ6Oxsmf0+iwrNx7qN0HAHWm1hPJoc8D+tkcUhYi+TwVu
	 FmGvDuDCkI2pOJu7hwIWHfmCtcb8jwvDcy0BCL2DiujEuGeXLAKVypObtLTsFE0Rulw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=YQ2yPgUk;
	arc=none smtp.remote-ip=209.85.215.197
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7141F606A324
	for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 13:04:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7141F606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=YQ2yPgUk
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cd68bf391e1so1333008a12.3
        for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 06:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792501490; x=1793106290; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TiOSNZMdnqqChU7eCmFOfWFFqcm5VOjZEu4im1R13jg=;
        b=YQ2yPgUkImKwegXLNDHIcOX5JNJ/5SLVpdvaMABJpkZMluLNOhHThjsFMwD/G+Jk+I
         shoEJu/zVkAvDY8UoDqp+o424Rkv8BlJO1EQJ2gxFh7kiwFDLcLrgxhIOfUUrhvQyjJ5
         nVKeHcAnqJbWISOBFNHYp7hyRcFxu7W5CYER2mmEX30YScCcF2uc9JCPrr/zb8V7SifC
         sBNzOEa/UxaMBVw63a/wZa2/3zabZuvNothwnoHPQRNj8eViTxRtxkbHBKuO5klMZgzi
         6dqXe3PxAp+Me/1byDOnk+SQEJwSQrZRNkWi7mB26/B1iH/wI49G+lkDHvxIsFpMqWYA
         lR7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792501490; x=1793106290;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TiOSNZMdnqqChU7eCmFOfWFFqcm5VOjZEu4im1R13jg=;
        b=ZPCcouylEd4RgPKq9QZKzi2vCa5DuberZ1i14SINtHhi9+7la7jGE4tKgXo3HdDUS8
         lFCnOcP+G1cQ/yg42+lMU52iOuxZNEXV2TVOB1reUDqZGvs41nzY1u2hMUVvlEdLk6oj
         hPzH77aj0ok51sVCbPZFWbNM/NG4FHCQcgyMRNgQ0nkcuFMU47ITXnUUccyEM3fGnx8W
         h8tp8fYeMYBoBDOQAEYby6TBz/jb7kuKRQlFVqot5Lqq2oRTIeliSGxrsIspaMK6aSTL
         yZQVwRFwqHPsxlK8q79TN3nWUyci4EqTQwbaL+svqUxbsz3B+PqjFCUeo3BGgdy7eIBm
         g+oQ==
X-Forwarded-Encrypted: i=1; AKwUvBzsnTAhEaxs1wBffx75EeWRGrBuqwybTmz3XO28u2KTSoT9HeiqY9wgYGsSqK08cbEgyLw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLX+fvHjQVafrqmrHoY7fObkW/NOKG0NkeplZ7PhIao7PQqtQxu
	Sox9VlIPdY+G8mgx+As4LMGo0J8i7Elbo48TCQ7caJ1utEqXnOVInUkOK3R9F5J/MN14n6AniWU
	1LweBPQ==
X-Received: from pjdn34.prod.google.com ([2002:a17:90a:2ca5:b0:3ab:c22:1eb0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2e85:b0:3ac:aa8d:19eb
 with SMTP id 98e67ed59e1d1-3acee29585cmr8240994a91.3.1792501489305; Tue, 20
 Oct 2026 06:04:49 -0700 (PDT)
Date: Tue, 20 Oct 2026 06:04:47 -0700
In-Reply-To: <20261019214611.404880-1-yosry@kernel.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261019214611.404880-1-yosry@kernel.org>
Message-ID: <atdm23p9cUTG7_MX@google.com>
Subject: Re: [PATCH 6.18.y] KVM: SVM: Stop toggling virtual VMSAVE/VMLOAD on
 intercept recalc
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: stable@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Jim Mattson <jmattson@google.com>, Kevin Cheng <chengkev@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, david@kernel.org, 
	Lorenzo Stoakes <ljs@kernel.org>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	David Laight <david.laight.linux@gmail.com>, Kiryl Shutsemau <kas@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Luiz Capitulino <luizcap@redhat.com>, 
	Matt Fleming <matt@readmodwrite.com>, Pedro Falcato <pfalcato@suse.de>, 
	Rik van Riel <riel@surriel.com>, Mike Rapoport <rppt@kernel.org>, Tal Zussman <tz2294@columbia.edu>, 
	andrew.cooper3@citrix.com, gregkh@linuxfoundation.org, sashal@kernel.org, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, Nikola Ciprich <nikola.ciprich@linuxbox.cz>
Content-Type: text/plain; charset="us-ascii"

On Mon, Oct 19, 2026, Yosry Ahmed wrote:
> From: Yosry Ahmed <yosry.ahmed@linux.dev>
> 
> [ Upstream commit 55780d8a1dcc93d2c4b33c565ada88df12c9f206 ]
> 
> Virtual VMSAVE/VMLOAD enablement (i.e.
> VIRTUAL_VMLOAD_VMSAVE_ENABLE_MASK) is set/cleared by
> svm_recalc_instruction_intercepts() when the intercepts are cleared/set.
> This is unnecessary because the bit is meaningless when intercepts are
> set and KVM emulates the instructions. Initialize the bit in vmcb01 base
> on vls, and keep it unchanged.
> 
> This is similar-ish to how vGIF is handled. It is enabled in init_vmcb()
> if vgif=1 and remains unchanged when the STGI intercept is enabled (e.g.
> for NMI windows).
> 
> This fixes a bug in svm_recalc_instruction_intercepts(). The intercepts
> for VMSAVE/VMLOAD are always toggled in vmcb01, but
> VIRTUAL_VMLOAD_VMSAVE_ENABLE_MASK is toggled in the current VMCB, which
> could be vmcb02 instead of vmcb01 if L2 is active.
> 
> Virtual VMSAVE/VMLOAD enablement in vmcb02 is separately controlled by
> nested_vmcb02_prepare_control() based on the vCPU features and VMCB12,
> and if intercepts are needed they are set by recalc_intercepts().
> 
> The bug is benign though. Not toggling the bit for vmcb01 is harmless
> because it's useless anyway. For vmcb02:
> 
> - The bit could be incorrectly cleared when intercepts are set in
>   vmcb01. This is harmless because VMSAVE/VMLOAD will be emulated by KVM
>   anyway.
> 
> - The bit could be incorrectly set when the intercepts are cleared in
>   vmcb01. However, if the bit was originally clear in vmcb02, then
>   recalc_intercepts() will enable in the intercepts in vmcb02 anyway and
>   VMSAVE/VMLOAD will be emulated by KVM.
> 
> Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
> Link: https://patch.msgid.link/20260110004821.3411245-3-yosry.ahmed@linux.dev
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Fixes: 5a1a726e68ff ("KVM: x86: Use KVM_REQ_RECALC_INTERCEPTS to react to CPUID updates")
> Reported-by: Nikola Ciprich <nikola.ciprich@linuxbox.cz>
> Closes: https://lore.kernel.org/linux-mm/arY1Wq6R9OY20ans@pcnci.linuxbox.cz/
> Tested-by: Nikola Ciprich <nikola.ciprich@linuxbox.cz>
> [ yosry: The bug is not benign. Since 5a1a726e68ff, a vCPU restored into
>   L2 (e.g. on live migration) recalculates intercepts with vmcb02
>   loaded, leaving vmcb01 with neither VMLOAD/VMSAVE intercepts nor
>   virtual VMLOAD/VMSAVE, so L1's VMLOAD/VMSAVE corrupt host memory. ]
> Signed-off-by: Yosry Ahmed <yosry@kernel.org>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>
