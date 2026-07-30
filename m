Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04005320A04
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 18:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785435367; cv=pass; b=IHLvCTN+B+VqiEesX08YQzbgwbFzX2dXNCBtDk2yJw5qo2D7Pu0u4knl5t/Q1ivTxSntDs3JFtYAvYGf4uf76UjZjWzE2f9vLmlVbYETFbLmlop2XpdS8w0xb2a3IR2rphy/R5Gfb5jp409HiCmrrUVOyRWOK8O9jo5X/NdGDV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785435367; c=relaxed/simple;
	bh=ACnSUSFGOHB+6aR5J0+hOwYkWmGuBgWWNFIJt2FZc6E=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PUhyU4fik8TqAiDpaj4aWXwifidB2zVmM9Ju77EmkxSz/xatBT5AQjCEPrg2GOes7CD3x1iIvBXQLYCqmyyTrnTdWyzPY1eCWzoLwwBuR9B2OwDxPOrJQasiu6dxL8uqwMtbsqpQsSGSAQ+T3DLA82vWn5/LPo7NYPrE6GMBMJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uUevmtbg; arc=pass smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uUevmtbg"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c9b373d5af0so73778a12.2
        for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 11:16:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785435365; cv=none;
        d=google.com; s=arc-20260327;
        b=C8oCrtVZKtc2yuanRu3BQ/73a09qlBg8UNgq3uLRukO0SFPhBY2Zdd9KHpWmx1tJNJ
         sh70sepkoUyERY3gjWchMQY/FLXpD0l9fJLHKEV9A3pMADQ6R2nx+6R8TtIYAcrx9K9l
         KKrgIZ3LsaSh1IaWaqYAxdb8HCR7jdHUHH8cFZ1xkMXadI6EqBIcdpE38+EhQef8iLBX
         UwQWqvYGMTBo5XcbUZLgSyKCU4ek3PDS49Uh16+lrIKvNYvgaF+UhnjcjD6cxE+abVQ1
         xmu+3p2CS4hjNXGDmkpvhLB5qarIo1fgqZb2KSAhRtyTZ6u/AnDY1szOHg++ii1Glfpc
         RxoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=jeT5JD84OLDwdMghWHFJO3a32W5zB/0PvPjAX4B/43g=;
        fh=usQEsVqfKhXI3BDDuqtIoTejBg1LrANG5U0rBPDMrEU=;
        b=RaGiAOfuD9pxxcsmRzgCS8ZyDii58jaXpId7voNT+2BsiBrPkUz0pgRtvbwqYMIQEl
         xbKiomA9LFeEkwGTVf6rKh6eVL+Idim9Zwo7EYVKpiU3xggYLCanQ0hl0zIkjh3CpNIG
         aKEuymqCmMafaFNv0Juii/V8TXljKmX+GU85xTs2cZ1RSCREaMWH7Y0XZBQRr0qGqqkh
         cLS9hxhYtoU0lXJeB2eY96NNR0Ljdrqc18SPguhKBmgWlnG3uGQPHNfecEVRxGfrnbfC
         EKDut/2H1LowUUzgPQD2pmm0dcyt4RzDMRYHacUxzVThekxcRcySRXWiHqLleRQrSQ+2
         XLDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785435365; x=1786040165; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jeT5JD84OLDwdMghWHFJO3a32W5zB/0PvPjAX4B/43g=;
        b=uUevmtbgrq6eb0PEmcfnczE2DsVt2FPLYYzJ6NrvCPQxcRUYMxfi12hjvgEDZ8Z42s
         /Dzi2a6LOW8zOgMaST4PiiSGpn0aP7SUomK4TkBKYyZR3/YRHXYfJns4FFXFnOuqYXYq
         iHxDHCjgAjIzimzymxzjeWT9/rt6t3baHpwqXglQwCJp3lMIMuQZcnUsGC77+NbQQA+N
         6jjaRTvra/0Z/7oJy2Etk+dkG0cYf3rbNlx5QQj3brNkJFXX+XgxO+mD+0bc4ODG21NX
         X4YbqMgGDDYdWevEaeJfBCrPWnsFQ7besi5JdnZFSESUgT7YKHRV13DUcBnEBec8nCFm
         QElA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785435365; x=1786040165;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jeT5JD84OLDwdMghWHFJO3a32W5zB/0PvPjAX4B/43g=;
        b=Po5N9YMMq1905ML7lRHAzmTaiFSQ8lrZXdLLqJKolyKszbXZataKVEQPZ6TwY5gaka
         Sh3s/jlM/84a8PvpihOSBS/a8w2v6e+i8dkk13V48KCxUYdvQJon2TSxuJetn+t8o0IQ
         REiuTPuFDou2mufjD2SIMOwcu4cHo9cQ+4b2MIxcxMK02Oze1JyBpUCLSq/J+Zy5W9VK
         8YFyfS91zu3roAWfoc77r+60FinE+e0lo24ohMtR42q7gOM8TwWM1HV02aIzJfFfsPgM
         8jhK8nC+HQUXcOdGdh5BHBgIHK/NXl3dkz5qnNLq5SfnrXx5KtujkOUKwDcdYtmYFlGa
         H9AA==
X-Forwarded-Encrypted: i=1; AHgh+RpPZjXuhBjOUkJ/lTYz9mr9uP3Y0NBhXk5iGprRx0mn3Ko6dmRbyugqQRHKDlPUZWidiEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXJri9AErk/LFxvcIC1aMzUfAsDHU/UO56f71OfEGWsJwnyYEf
	ChNKn4RzTeg4YUAKr4U2phx6r5GAmHczLrzpxKf+VwqiE1Mwbudi4baTybWTE8sNmpWd4h8ILca
	HfqcDgGV4U87nesfp3qZjBAykQ5/1csMpzV+G65jk
X-Gm-Gg: AR+sD13QgOVTlmtNzqg1l2Bhi1HaheozGEzoRcR3Jfewvv4iySS3xDCj1NklMuEdSTJ
	CNu7RLQbUNO3qjOotmuzeod/OgPgNnHzCxhHiMmzHGunhpCG7sCkXYWd1f+KU3rfRJB6G/TulSO
	v23P7FFCOjoPVulOGYeUXjviu36tQdNeEIcBeujH6QoY1Cfv+PInMK3DJ88GqVRdYeO3tusizSk
	Q7b23ex58Ue5/lqs8NVXY63dRlZj+BBa/rMlrpCOiG2Peciv0x0FF6CHJhWw/WxnNJ60dY29VGZ
	uJZbal+YE6BjnNqrss87YHaJCP1Ad6pFkzvfULB/wWBP3dcIDrNASLGmgBiX9KZA044KrxzGw6Y
	dNQ4VcWIEarvUfJgf5q1J11qVDWNwudkZ5Q==
X-Received: by 2002:a05:6a21:699:b0:3c3:a948:e2dc with SMTP id
 adf61e73a8af0-3c900759828mr3817647637.27.1785435364789; Thu, 30 Jul 2026
 11:16:04 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Jul 2026 11:16:03 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Jul 2026 11:16:03 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260728121138.1103610-9-tarunsahu@google.com>
References: <20260728121138.1103610-1-tarunsahu@google.com> <20260728121138.1103610-9-tarunsahu@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 30 Jul 2026 11:16:03 -0700
X-Gm-Features: AUfX_mwuYQlBmJdhbZSf7MRgmwyNG_KfxbR45Duou2tcQqjIodL3cnnQ31aoSzA
Message-ID: <CAEvNRgGJ0s5Vu8xRvfPmA39p2Bmkr-U7JFFkshM9Dyk9j+t-YA@mail.gmail.com>
Subject: Re: [PATCH v4 08/11] KVM: guest_memfd: Add support for preservation
 via LUO
To: Tarun Sahu <tarunsahu@google.com>, fuad.tabba@linux.dev, 
	Andrew Morton <akpm@linux-foundation.org>, seanjc@google.com, dmatlack@google.com, 
	Shuah Khan <skhan@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, david@redhat.com, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, sagis@google.com, 
	Paolo Bonzini <pbonzini@redhat.com>, Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>
Cc: linux-kselftest@vger.kernel.org, andre.przywara@arm.com, 
	michael.roth@amd.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	will@kernel.org, vannapurve@google.com, maz@kernel.org, fvdl@google.com, 
	kvm@vger.kernel.org, oliver.upton@linux.dev, kvmarm@lists.linux.dev, 
	alexandru.elisei@arm.com, skhawaja@google.com, aneesh.kumar@kernel.org, 
	linux-doc@vger.kernel.org, David Hildenbrand <david@kernel.org>, yan.y.zhao@intel.com, 
	kexec@lists.infradead.org, suzuki.poulose@arm.com
Content-Type: text/plain; charset="UTF-8"

Tarun Sahu <tarunsahu@google.com> writes:

>
> [...snip...]
>
> +static bool kvm_gmem_luo_can_preserve(struct liveupdate_file_handler *handler, struct file *file)
> +{
> +	struct inode *inode = file_inode(file);
> +	struct gmem_file *gmem_file;
> +	struct kvm *kvm;
> +
> +	if (inode->i_sb->s_magic != GUEST_MEMFD_MAGIC)
> +		return false;
> +
> +	gmem_file = file->private_data;
> +	if (!gmem_file)
> +		return false;
> +
> +	/*
> +	 * Only Fully-shared guest_memfd preservation is supported
> +	 */
> +	if (!(GMEM_I(inode)->flags & GUEST_MEMFD_FLAG_INIT_SHARED))
> +		return false;
> +

The above check can probably be removed. I think the core thing about
this series is "we can preserve any memory that doesn't have any
encryption state that goes along with it", and so the check for
kvm_arch_has_private_mem() below would be sufficient to gate that.

> +	/*
> +	 * It makes sure that no memory can be converted to private
> +	 * even if it was initially fully shared (in-place conversions are
> +	 * prevented).
> +	 */
> +	kvm = gmem_file->kvm;
> +	if (kvm_arch_has_private_mem(kvm))
> +		return false;
> +

For now, has_private_mem == has some encryption state that we can't
preserve yet.

This also gates off KVM_X86_SW_PROTECTED_VM, but I guess that is
intended, since when work is done for preserving encryption state, we
can then test using KVM_X86_SW_PROTECTED_VM, and only then, remove this
check?

> +	if (mapping_large_folio_support(inode->i_mapping))
> +		return false;
> +
> +	return true;
> +}
> +
>
> [...snip...]
>
