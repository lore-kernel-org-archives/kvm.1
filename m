Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F65421249
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 08:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785831892; cv=pass; b=udC+02LaTt2MjvOBYufCvNzfoeUmGlCkshErVbQMA3Qlo/C4dqZ98jC3ChTVwGpxIdCCxd7FAOwF/2kjCvaQR6/LS8ntsIcrswJYLvV3KwLRi/sub/Lbn+zPbwB1HGwrV4YS3qdn/1juvBGU6h7gtKI7sS3CpzFBT1AphQwlmN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785831892; c=relaxed/simple;
	bh=E7A62dEXRMnTvouK15ML4xNn9IbWSm4bfkJkGy+Osog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UezNtjgCCfMnC5JbY/Mh2xL/fj77rE/TUx/flz/1QKqmDoZUF2HA/R03Oa9pf2eEmxN4NrQtagewaaivp3aau8QniWaL/CKikQ7pWjjO6pGux9o3+8QT0qVHBH4gG5hwlhjF99V1rBZwGwBipMh42zPgU/JACys/P0+opFv6KeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TkRh/NRR; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XXm5s2IQ; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TkRh/NRR";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XXm5s2IQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785831889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tm8UobsJTlbPE9vGUwkb/Bbwe8GB4ZtONSzPRFILqXM=;
	b=TkRh/NRRKFbCG5qrNQDrBST2BI9M2pp8Bwc4yze5vqR0jrG4qlgAdHKEuNDkPfgBO+qhSV
	GijK5VyG/JM01nJ1zApyTmspcnJOlXsmDo6B96fPcjr08SJFgfCwVn9cxq3F3H4BsnuWcT
	oJ3Mtzjnlyq0JRgOIP8qwgXex0ZLsyM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-k0972c0yNHq3MdH_r_t0OQ-1; Tue, 04 Aug 2026 04:24:48 -0400
X-MC-Unique: k0972c0yNHq3MdH_r_t0OQ-1
X-Mimecast-MFC-AGG-ID: k0972c0yNHq3MdH_r_t0OQ_1785831887
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47f810c8aebso2602623f8f.2
        for <kvm@vger.kernel.org>; Tue, 04 Aug 2026 01:24:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785831887; cv=none;
        d=google.com; s=arc-20260327;
        b=JNBOQPFxsuU4fTgWTPIOpMuxSz8OAzqA2OcK6R4qWIxCzDhGXEvExQvj4m2Fw/7CBl
         1+cLcFu5BKt73tRoKAMp9vkweknufGnUW7dZGtf9v0JaxCe0kuSVUUYlRVwtt7aZbwOM
         vZ7hFB79v6OHRt8Gjuqgz1XyoLEgLfNTDVTfCDN50BeHixfV1yJGDB5l6HlaSuyQOoZv
         p3C6kd1CmnrbYWSPzqtsv35xPnzyJlN/CzeiSwVGaoth4NiF/0dkGhCJemho/AaLFMzQ
         5PY90aV6E56y8Fqgbqn9NoUnvQSmziIvA4qMCe98Xh2sWhWfIy6OhnHUaLkTG3uU8df8
         7GVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Tm8UobsJTlbPE9vGUwkb/Bbwe8GB4ZtONSzPRFILqXM=;
        fh=GmM2LtNLsvtcuGWW+ktQLZ54IZGx+3MXga1HW7akK4I=;
        b=jy2Tci9Qx5KI55cVwvnEkEZRRHdLLlRrnvuDMlwlYqhOnFj8LaEVZWqLy/S2Hem8+s
         vNyZhOOmPusgr/lcfHAUeE4o7f42UYs02SPMjDoo4Yw8+vRQR0ilxqAQwJrjMOVVw0BU
         SMimFJYgI6fkJZ8UNw4ajIs2Myh39F57Z3udg9Kd/ibp6iZDV0osGaToG8uTXJxz0cDQ
         fEAjjG0DNOT/vyEN8s1Ehic3WQp99Bdapj1SL5wATwq0eDEB4fegMemLpjNF5GWjs4A2
         5TNy9LgKHWAmKoObL/cpnaXzeyUasrjSaYlEP4Cor28fhodTNG0c4ghdEGGq+4/Np5Wn
         Fw5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785831887; x=1786436687; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Tm8UobsJTlbPE9vGUwkb/Bbwe8GB4ZtONSzPRFILqXM=;
        b=XXm5s2IQ9WnnfT9uUNYHfa2DAMbZAQWWXQ2jLfmcMtnWcqnGt4jYt72e77JtSHUKEy
         CT4sjQo37m/0YYMYMuj4LjVt0ThUENI4tl8VEtpY18gjbm7pKypW8RiOLr80Lj4DiEg0
         4bbKsFmDCuBzOib8WyyVT0GrocCjUPSKrw5t9Ux/Fl4FUk1mx40itfq+9noV2glHtwdT
         clR/eTXwTJydojPTHtDz4AQt5mJ5Blas6JeL6bGwhjZmw6JJd9v/qibBpo8OymtttJ9x
         aq3jx+PjzywMl3IWCKSHn8JBtokPdAEI1U0eHoRvZoo83yk2Ed6uEptnnp2TyIYL4yCK
         XbyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785831887; x=1786436687;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Tm8UobsJTlbPE9vGUwkb/Bbwe8GB4ZtONSzPRFILqXM=;
        b=nqgrMfaZXaYSfif9pIRelV54A3OXTTfecN4Qm8Qw0njp4AK8OJWCeEI9bNq5MJsFGm
         cNJ+EMl4ZCMWipGvR5KUEsJAc4Ta+8BNKKfENE6ZdUAWy7u9vrwcO2TI/CjPIvrEUKYU
         UdAU/SBGDj0vjkipcDBC0yOxMXzMdAbKO9t+zPuWVxX0sgaFhGCh9LJajaylYbu7/rfd
         DtV2sI6o/vjH6YCouYqXBEb5QrRi4VDKntBjo+vPlvfa2gFcbTePiSi8MlwndGZ3XKmo
         AJwRUSILTQpkGt+xcKjhBZ6uDhU2c9dgTGr9NinnMLXmR2rU2QQszyOgP2JxrYzZwPBT
         dWiw==
X-Forwarded-Encrypted: i=1; AHgh+RrkQsYPfbiwI80iPVNHqZIcbwCI/02H8XvhNQDxNG5LmBtR4S863uX1uf8tPBwyFZUNVT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuxYjdsLoZtgLf0XVMoruuhmJD3bTpiH/4lOXUNe6PC0jDoXFg
	rmSlrrC0HEBgUNKx2kvjA2kHi+E+t9R0aiO4cChW8aOP+z8iDBl2BNOTmJCQhAMmfgo0sGEmpEQ
	DW83BhZNAqjYaRrt9uQK+8AE4VEFPWuwqiVW3oz5UBfSdsB7L0AMSkgl7d/YmGAE2zEXZ5fO9Jy
	1Wu8g6Is7kJ+dXZmBjY57e9FADF8A5
X-Gm-Gg: AR+sD10b9ERB/wq1Q9gqPkq0Lvh4L2ZP9U21119+QdtouZ70tZ2Lz97oPedRRJysOpY
	0a2PPZGLDgXFu450FZLhSzrjQlVNOcUispv+z5sx4m8FYPQ7loQpvoxNFPx30W8PLiXMs6/4Wrf
	UTZVt7XThmIk+r+QUkMK9RFDlJ13CKl62pqwEE16T+/pKD9GJ5+wUi51Xgcr24CKyJ3FTDtQ6+1
	AeqfAWnBffLqzoFYC4QY0OqZ0Yf5C4jm1TV6Ho4GK088Rs+nOcrROpZMfQ=
X-Received: by 2002:a05:6000:25e4:b0:47e:aa3e:e75e with SMTP id ffacd0b85a97d-47fd72ba455mr37381051f8f.10.1785831887570;
        Tue, 04 Aug 2026 01:24:47 -0700 (PDT)
X-Received: by 2002:a05:6000:25e4:b0:47e:aa3e:e75e with SMTP id
 ffacd0b85a97d-47fd72ba455mr37380975f8f.10.1785831887214; Tue, 04 Aug 2026
 01:24:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731160514.1101989-1-pbonzini@redhat.com> <0a9c8cc8-1fa7-4f4c-b7df-e847925c2b24@kernel.org>
In-Reply-To: <0a9c8cc8-1fa7-4f4c-b7df-e847925c2b24@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 4 Aug 2026 10:24:35 +0200
X-Gm-Features: AUfX_mzYzfP1Oin53-9hO_78pedfHqy7zxUVYNXXragKLN1GkC7l6UbBuVt8H4U
Message-ID: <CABgObfb_FN9r+D2F=GNsADP5xt0syFztmy-x==T85ovZKyopRA@mail.gmail.com>
Subject: Re: [PATCH] mm: pull writability check to follow_pfnmap_start()
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Alex Williamson <alex@shazbot.org>, Fei Li <fei1.li@intel.com>, Peter Xu <peterx@redhat.com>, 
	linux-s390@vger.kernel.org, linux-mm@kvack.org, Sergio Lopez <slp@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 10:55=E2=80=AFAM David Hildenbrand (Arm)
<david@kernel.org> wrote:
> > index 485df9c2dbdd..34c79b5fcb9b 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -3136,9 +3136,12 @@ struct follow_pfnmap_args {
> >        * Inputs:
> >        * @vma: Pointer to @vm_area_struct struct
> >        * @address: the virtual address to walk
> > +      * @write_fault: if true, fail with -EFAULT unless the mapping is
>
> Just wondering whether EPERM would be better.

I considered EACCES, but EFAULT seems more appropriate: it's already
what most callers return, and vm_fault_to_errno() never returns
EACCES.

> > +      * writable
> >        */
> >       struct vm_area_struct *vma;
> >       unsigned long address;
> > +     bool write_fault;
>
> "write_fault" is a rather odd name for this, given that this function wil=
l not
> trigger a write fault.
>
> You want something that matches FOLL_WRITE.
>
> "write_access" / "check_writable" maybe?

Just "write" is what mm/ uses for local variables so I'll use that here too=
.

Paolo

