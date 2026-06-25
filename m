Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EDD2F8E9F
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 18:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782411603; cv=none; b=VgC5Jw+WvGGiKnqtZX+GgKCvjcCoe2RiCLx9zYkT3qo4wFOIh6UG2cnwaHivGtThNJTE2xSdHIAWsvZrxJzM8KfuRmeBScILehKeeHEH0foD0hSQ3xcHhh6LpWMa4qgqzZVX5Q3kmoJuu0p7gKztZ+NmbYUFnxlfaELDYE/zBLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782411603; c=relaxed/simple;
	bh=XxndvljOt9uUmD9D72rN/iNmVCcGubaSjNNlVCf2UNQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CY2XYzYuvIuofYGZHG0kstHeBylq9EqGTVk+E53wYSZRYYIaiZZUvtcCXI8pwxQf65s8HG1/ggf6hStzbXP39UMDUNMMhwM49V2tera5zGVwpVre/KcxQu47kCAAWhQSiWd/CyaaNcVNliIYXb8GzCO9QBluzZHUmnhFbEcE5fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XyOGoMEX; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XyOGoMEX"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c7ef28ce24so1323845ad.1
        for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 11:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782411601; x=1783016401; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ymb11MHWr84mbZGvyE15DfTishs1pDuYphEFb//5g8g=;
        b=XyOGoMEXSDZcc/y/BjnEs5FkWrnabnpyiDN1aJVPr74MPt07irywkjIm8CH3iwSbrK
         r8XtwefSbJVNn8ulvHVzooTVVPC9BfizHEZWloqy+zUfKbrPQadVHXH8qxXJoCTYDvBE
         0rC2ixuaiiPSVmqWmJDVo/ldGaf8u6ihM4n/0Z/G0TTDgxBEUwvEwbjnIi7rN5tZ8dT9
         nx6INJkSAJApPMPXzb3kNy2iTkbT+vNkTxZJKbUHiBABfrSWA3KmuMY6WHGRNz2PLPOW
         mB3Y+1kCRMdxb903dcFPyi7NLJXk8mvpMLJuMfWlIIFS7PrcuZHgo1Iy9BBKA/BWYw/N
         Rp0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782411601; x=1783016401;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ymb11MHWr84mbZGvyE15DfTishs1pDuYphEFb//5g8g=;
        b=f8BictUlvZb0Azlo8x1CM5OxTn3VpiG+Olj3ixNZI0aZDlxH7EqvAj7ZLAQvzhllsh
         Ty9yEeqKoHECPQw5ZRLJmDS5xs2razPSoiMYSfY9LfojD0AVwcQ+kw6J4zJ8OYqujl7H
         emjuM5K+RqMaqoftjCs7fBlbBB002Wb5D4RvMJSji5azxMdtVlS3TY+Y0+w2SkcF6Xle
         Zct6IkRdwY40hpj2MWwLCrf+O1i/sXj3EPyNHCJ9i235l3A3Eoq0m+hbJ+DEQfpzaHpg
         VXIeQX2SrNn82T/QpdywjmLAxjKUt8Uuiz7W3C1OXTeaDuUUwNvsy9kcLlP4HBx1C6zD
         EEOQ==
X-Forwarded-Encrypted: i=1; AHgh+RrLZLXw/8rzPwn1Yzk6MZnno6ySa3M72ETV6rfOpPWwfT6Bji5YTYEsOxPON72mVQ2DI4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJuFtHaexv25wRCBNn8lSCZnpyNJwcbqG84ObQu3uDBV1oth4i
	ktF5BxKFKU5INzsXEwY8XGob0fGn1/e9yzJXI64iA3IoO/EidgOK/c0l3iOqP8EpZZGwooNM2UM
	1qqNkxw==
X-Received: from plmt4.prod.google.com ([2002:a17:903:3d44:b0:2c7:ed23:f48b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d482:b0:2c6:8d95:fd6d
 with SMTP id d9443c01a7336-2c7fc74bd33mr35612465ad.21.1782411600543; Thu, 25
 Jun 2026 11:20:00 -0700 (PDT)
Date: Thu, 25 Jun 2026 11:19:59 -0700
In-Reply-To: <20260527-kvm-locking-docs-v1-10-4fe8b602ff47@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260527-kvm-locking-docs-v1-0-4fe8b602ff47@google.com> <20260527-kvm-locking-docs-v1-10-4fe8b602ff47@google.com>
Message-ID: <aj1xT7XkSpkqNFAI@google.com>
Subject: Re: [PATCH RFC 10/12] KVM: guest_memfd: Clarify comment about
 gmem.file vs kvm->srcu
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Tianrui Zhao <zhaotianrui@loongson.cn>, 
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Fuad Tabba <tabba@google.com>, vannapurve@google.com, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

On Wed, May 27, 2026, Ackerley Tng wrote:
> Clarify the existing comment about synchronize_srcu() and
> kvm_gmem_get_pfn() to provide further context. Explain which
> synchronize_srcu() prevents races with how kvm_gmem_get_pfn() is used.
> 
> Also point reader to documentation for better understanding.
> 
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> ---
>  virt/kvm/guest_memfd.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 69c9d6d546b28..f2218db0af980 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -711,8 +711,13 @@ static void __kvm_gmem_unbind(struct kvm_memory_slot *slot, struct gmem_file *f)
>  	xa_store_range(&f->bindings, start, end - 1, NULL, GFP_KERNEL);
>  
>  	/*
> -	 * synchronize_srcu(&kvm->srcu) ensured that kvm_gmem_get_pfn()
> -	 * cannot see this memslot.
> +	 * This is called when memslots are updated, after the old
> +	 * memslot container is no longer in
> +	 * use. synchronize_srcu(&kvm->srcu) was called there, so
> +	 * kvm_gmem_get_pfn() from KVM's guest fault handling cannot
> +	 * see this memslot. See Documentation/virt/kvm/locking.rst
> +	 * for more information about kvm->srcu and the memslots
> +	 * container.

If we want to add to this comment, I would much rather do so as part of an update
to kvm_gmem_release()'s comment as well.

https://lore.kernel.org/all/20251113232229.1698886-1-seanjc@google.com
