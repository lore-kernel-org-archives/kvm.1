Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C2235F61C
	for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 13:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773237192; cv=none; b=Z8wqLDfeUXzEhUV7jVLYKMkUMYUTAfmp/t4qy6uz03RwkWBZRcMerThp0Lt8/uO+dQFFPVwRr9N/fOn3pXG7cQfZeLVwYOs4qdh59bkrKIAbbNx4M37w2NzE+TXeqYjYVUAzYF8ANhHF1PURgTC4BoV+f8fHAxJ9fwbLlv+pH78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773237192; c=relaxed/simple;
	bh=dsjoVHQwySAScoTUu+/obDtz+Uxd5/FqEcA7GdZJUyw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VLR5Ht+mtfVSiwzYEZY+BdR+rPp9lX4RYUiJGJ9MZdWVZW4dJB8TOpjm6mS4t8Coji1x0NGGpjVPFLY6UF7iZPgBVoZ9eRfcs4HnqKKb/Bw1VlKhecJZ6OrebDi9MvxtjbnESqaTbwsNKvpJm7uFjvJ5uLXlz6Z/YJb4UmedsQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YSKH0mkJ; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YSKH0mkJ"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ae4e9577ceso536587765ad.1
        for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 06:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773237188; x=1773841988; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NAa3aHLl162rPpJr9UXwgPodsrtcAfdhM5O3Q0Mg11Y=;
        b=YSKH0mkJP35Zn48hp7jqnSGpI8nvg9P1Cn+NvbWMzDVlpqVWDT6FwbhYMXlJZ4dOK7
         ApUtWnsLl4dtb3Pi9uq3seJwjAjvsrgbitI2vaojt1DdWZw3B4gVzJTzHMl0hBSyEtQc
         vPn0GpzKr5WsmyfI27RreYSWMaDelxuvlmd5Wp8eoIJj1nWHzu73eOt1DAk4K6VsX7UR
         LJq7WrqqP+XfcCsKTMHqMCgPC0kYQNRUq+N2Cp61VJMn7sSYrVI3uIfcXMyTE8W6B0iz
         HH+zdrxbETVW3xA0xB2K6b76AiRrYeGSLAugsWqRyBXOKbm8VxUvWnhvLU7LO2vVZCH8
         n34Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773237188; x=1773841988;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NAa3aHLl162rPpJr9UXwgPodsrtcAfdhM5O3Q0Mg11Y=;
        b=TA7epnoSTClky+a6lXwYlabLs5wnohI8/00+87jimkHCYZIUztz/acwVgendDJ2T6m
         N83rgaUndOeSfklY3aufY2dJQslDOvnjBVf9QdGfBBpTJgvfYb17n5N+zE2rxZ0KcKA3
         zJuCpXayDeabg6bPy0b+5ZCWqfded55+JbGUw4Lq5mCxzxZyTN1mXO6SGH6Jvuc5kf8l
         JyWKCAX4Pu1InaMXMAgQmaHx8mIEjnnepiH/vR8GlCQa8fESLUs8nM7OKJcDi+RrTwql
         6h9cyMmTgHY0mf8B/ExnuFsFkbB4tvkVaLlHZUhw0ZW1MhvxkDQqHgbZHTlLOuzU8d8R
         FxoQ==
X-Gm-Message-State: AOJu0YxNDsuvE6rKyg92QjBPMNU7cmrBeGM7EBNdQ+bqNlVSYDmf+CKQ
	gsxc/Z+8bUNRVlcQmWfFI0FpHd/cmi4Fv9wfs2/GN9AZuQBXTtfW160E9iSC5lGAUKnP5YOYQim
	J7y9+CA==
X-Received: from plpw17.prod.google.com ([2002:a17:902:9a91:b0:2ae:4d0d:bcbe])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f710:b0:2ae:62c8:771b
 with SMTP id d9443c01a7336-2aeae76f58cmr27864595ad.10.1773237187756; Wed, 11
 Mar 2026 06:53:07 -0700 (PDT)
Date: Wed, 11 Mar 2026 06:53:06 -0700
In-Reply-To: <20260311105047.18517-1-0wn@theori.io>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260311105047.18517-1-0wn@theori.io>
Message-ID: <abFzwjGJm1j02L36@google.com>
Subject: Re: [PATCH] KVM: clear map->gfn in kvm_vcpu_unmap() to prevent stale
 validity checks
From: Sean Christopherson <seanjc@google.com>
To: Taeyang Lee <0wn@theori.io>
Cc: kvm@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, KarimAllah Ahmed <karahmed@amazon.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Mar 11, 2026, Taeyang Lee wrote:
> kvm_vcpu_unmap() clears map->hva and map->page but leaves map->gfn with
> its previous value. This creates an inconsistent state: callers that
> check gfn != 0 as a proxy for map validity will believe the map is still

But that was and still is flat out wrong, '0' is a perfectly legal gfn.

> valid when hva is already NULL.
> 
> This pattern caused a null pointer dereference in the 6.1.x LTS branch,
> where vmx_guest_apic_has_interrupt() checked virtual_apic_map.gfn but
> dereferenced virtual_apic_map.hva unconditionally. That specific call
> site no longer exists in mainline due to the gfn_to_pfn_cache
> refactoring, but the inconsistency in kvm_vcpu_unmap() remains and could
> affect future kvm_host_map users that rely on gfn for validity.
> 
> Similarly, kvm_vcpu_map() does not modify the map struct on failure, so
> stale gfn values from a previous successful mapping survive a failed
> remap attempt. Clearing gfn in kvm_vcpu_unmap() ensures that after an
> unmap-then-failed-remap sequence, gfn correctly reflects that no valid
> mapping exists.
> 
> Clear map->gfn in kvm_vcpu_unmap().
> 
> Reported-by: Taeyang Lee <0wn@theori.io>
> Fixes: e45adf665a53 ("KVM: Introduce a new guest mapping API")

This is not the correct fixes, the blame lies squarely on 96c66e87deee ("KVM/nVMX:
Use kvm_vcpu_map when mapping the virtual APIC page").  The API even provided
kvm_vcpu_mapped() from the get-go; why commit e45adf665a53 checked the gfn, I have
no idea.

> Signed-off-by: Taeyang Lee <0wn@theori.io>
> ---
>  virt/kvm/kvm_main.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 7a4fd1dbe0d7..88fc8b20aa8f 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -2887,6 +2887,7 @@ void kvm_vcpu_unmap(struct kvm_vcpu *vcpu, struct kvm_host_map *map, bool dirty)
>  
>  	map->hva = NULL;
>  	map->page = NULL;
> +	map->gfn = 0;

As above, this is at best misleading.  If we wanted to harden this, we should do

	map->gfn = INVALID_GPA;

but I honestly don't see the point.  Yes, we had terrible code in the past, but
the above doesn't prevent terrible code.  E.g. the correct invalidation wouldn't
actually do anything to make the terrible code less broken.

We even (somewhat unintentionally) removed that terrible code in commit 321ef62b0c5f
("KVM: nVMX: Fold requested virtual interrupt check into has_nested_events()").
And that commit was tagged for stable@, it just didn't apply.  If we want to do
anything for 6.1.y (and 6.6.y?), we should backport that entire series:

  https://lore.kernel.org/all/2024072925-straw-mashing-54f6@gregkh
