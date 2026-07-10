Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07A01519B4
	for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 00:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783643660; cv=pass; b=LrCnZC+5CP7qqh7yS4hqIL2/Ta8MOIi0wcdXEX1EDlwl+5JDBwgQYOfQU2YDmQB/Yo1kDW7frCOvVFQDgV/yZ3JqJXbDBOq4VbMzHoFXRjWqw1VKzwhlOugYbhoPRpvZgegP6YVSawZDIqPyyEvTra4wF7gy1ArYFszHCbTue64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783643660; c=relaxed/simple;
	bh=Fpci2PFhWFDp0SxYa0uA9llNGYpr61M5SYI2cHRmg88=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P6Agch95E/dUz/lx/+2Ua1GLoRoSUqTJzbOmt7dqUe9OlLbkW8xrhQC85F7oVX0eoqfX025wrf5ly6gbatjnKjBNomvITUIU/3DTCrV/hfHApK5KVCaDHRdQp4Ojp6X4oj0C94RRlnMI/DQJKHrtTD25t+n02lMPQWGBrObksOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S0UmSGL7; arc=pass smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S0UmSGL7"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c99eaa1f020so372027a12.2
        for <kvm@vger.kernel.org>; Thu, 09 Jul 2026 17:34:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783643658; cv=none;
        d=google.com; s=arc-20260327;
        b=cP9TgihW9O4JfwWeP2CynKJOuXwVnOaSucWvAHD0Z7HfJjAbbiteD7eJ7mk4P9HfFC
         GrjLs7yaMPM9VCiv87KaAri/QO+jru6C61bmn8vxUlRjA5lFaKslDlrZoc71iWsc3IZG
         E4gziRStgCmJaiG5sc2cC5YwTMQE9kJMUoOIDyf3DTlMiu94Iz9VHkco48BtuCbdwBN0
         MAoMN28ayTIFHLsEXYqy8D01e3DkP7x6EaZuzCsd2GMzJkt7VIS9KQJUNdUE/3CnQMXj
         MuRJtqaDJXUKB/wexrtGSmU7Cj9zLYpUdteEXjkHYNa9h1jQqQ49vmxxSVjErhOfnm0n
         NcYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=qHQiaiYlpGZeRITikE8QGQW0TBe/vGQnjTYE5b8SRJ8=;
        fh=wfw0hEOlkq3EUE6azXKmcRqOiVR9wJZgs69aE8Vkuuc=;
        b=T3tQfiLt4TtVq0SrjkioT/i26Ph5jvyFObiDdwIMdb5+Md6wXpIVet34meLl4WNCNs
         Nnq6lFxhb3ERy/DjTiYpu47zoA8Wslv/CU+zU5uvZrytA0ykw6rBYKkC7G7gjDWbS1MV
         c0xPrpqam5EgWODFErY3thZKDqAHMdGl29J1kBCjMzjMM4PX/6YINFx2PrwgboNbhj1z
         QVsW1Z37Mktc4VAf8p7A7WhTLpON0uLG+VhcVbH3R5hvBaXQLj8edpBbXrSw7IIrkctR
         li5SFlaanbc1j3XWIX5cMv52E93IRlxitq2knwkJ9eLTqaPm7zY7BDTNQVuD4fQPxFNG
         gniQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783643658; x=1784248458; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qHQiaiYlpGZeRITikE8QGQW0TBe/vGQnjTYE5b8SRJ8=;
        b=S0UmSGL74gAPiZY8IMFvqJFBo5lYT72nO+XbDlfbl2iHtrQjlva8Oe1+n+kuyHkKDn
         HhdEorjvgMH3LxbguUfP9y91i82yN/uVxeXsqH7C73OR3vsvH6v4nVkxs50T25S12+X6
         kvHJD+AmOpTEAzJb13JbkSVcCyHhAExcLS6w08aAU03Gm+COqCNcDwcQwZihcpDEmVOe
         tHpcumedGMeK4Zxbp57LBlNDqu/WWrd+K9Bhb6LrTCJVLl3KaC2N2rGkABaV6EyphgYp
         TFrGhQs08+2iIodxOyM3MmydfoG0IGwnLvFJE08/P6vp8pk7SCXXe/NeDAVDbikWnXmf
         wJ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783643658; x=1784248458;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qHQiaiYlpGZeRITikE8QGQW0TBe/vGQnjTYE5b8SRJ8=;
        b=r/ZG+OKLSVgC/x8wOxWhyYusXgT+PRKqwtNJI5Rgm0vuMC+lXCp1PHay8mc0ZloRrT
         XF6NuqI6KcuMsw+G4EoIWFfPuNMNze+YuPijbKikhu7p0vRTtFDcS05KGPPou9bAUnkD
         yCXnSMBbWt8xenRrVwiyeW3Zx3wY4oQ7lr+LBHtQaMVEw6rnkYHTew7d8GaFPb4TnOX+
         3l9e3qNIpE63dfmYrxbt0BLorALuNobhFK1kCH84nkEDbwmAg4YzJ+bVjWSHUmoc+n8E
         eDyHqhif8RFjaGj2FYoRSpdUkTYNqPJoZgYvBHc4sU8MxLUFG5UJaPpY2UVgnY/OSoK2
         fUSw==
X-Gm-Message-State: AOJu0YybzRP4puzeF0FqDQpIeiSzuv2GUUOQI1q/eSOof0psXzbdk+9d
	c7qhoVbpLi6MSQIO8otCMGfqSAnsNtsJy3dd0MheCaAsrou4myxFdvD0jpECSL3lJCZN3DtrJSL
	nrUg7kWfwOz61syqKYcJXti2ualbIcJyToxbdPyK8
X-Gm-Gg: AfdE7cn33UnCUdTC8RUskJyOE7izZ7kleqNgbfNZSkUuLemoFfTufvEooFZ5Mk9sbQx
	3zGSQj8wM893oGk8iR1f1d7HEIlbcQZnngIh9o+TBq07/mSVCemR59N3WIoMdLOrzv0a77qsJBU
	82ErnhS1vCNzDblxbFE2j/YAAxkfpxPeVRfOXtbwSeP+eH+UEZ/99EaH69A+uFljEswOJEq//Eq
	WjrFeB+bRyQFxJwlLEEClQiyfE45TliTwvL957hIgg34kBy62EotSbuyet1J56vVupyjKy+z+9Q
	KxEQbNFayjxm/LCkZIuGaPHxJTrfVPxiBVMPgRUfRwoSWdoSx6PJIm1v4Uk=
X-Received: by 2002:a05:6a21:6e86:b0:3bf:d0c8:2a8b with SMTP id
 adf61e73a8af0-3c0bcfea250mr11158681637.20.1783643657594; Thu, 09 Jul 2026
 17:34:17 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 9 Jul 2026 17:34:16 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 9 Jul 2026 17:34:16 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260709204948.1988414-19-seanjc@google.com>
References: <20260709204948.1988414-1-seanjc@google.com> <20260709204948.1988414-19-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 9 Jul 2026 17:34:16 -0700
X-Gm-Features: AVVi8CdAoqtHs8dRShwv5YMICUp2kNIIo7CNm-imL4eYlQV4vu91H9ZTf-bkVeM
Message-ID: <CAEvNRgGtFZtY-Sy4RGzd68Dq0EB5Sruxu9tgpU+1XXYKfws-uw@mail.gmail.com>
Subject: Re: [PATCH v4 18/18] KVM: guest_memfd: Combine .gmem_prepare()+.gmem_invalidate()
 into .gmem_convert()
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michael Roth <michael.roth@amd.com>, Hyunwoo Kim <imv4bel@gmail.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>, 
	Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

>
> [...snip...]
>
> @@ -532,7 +531,7 @@ static const struct address_space_operations kvm_gmem_aops = {
>  	.dirty_folio = noop_dirty_folio,
>  	.migrate_folio	= kvm_gmem_migrate_folio,
>  	.error_remove_folio = kvm_gmem_error_folio,
> -#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
> +#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
>  	.free_folio = kvm_gmem_free_folio,

This part looks odd to have CONVERT gate free_folio, maybe this is where
it's nice to have CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT ifdef the contents
of free_folio above.

Not a huge deal, thanks for this cleanup!

Reviewed-by: Ackerley Tng <ackerleytng@google.com>

>  #endif
>  };
> @@ -802,7 +801,7 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>  		folio_mark_uptodate(folio);
>  	}
>
> -	r = kvm_gmem_prepare_folio(kvm, slot, gfn, folio);
> +	r = kvm_gmem_make_private(kvm, slot, gfn, folio);
>
>  	folio_unlock(folio);
>
> --
> 2.55.0.795.g602f6c329a-goog
