Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4FB41169D
	for <kvm@vger.kernel.org>; Tue,  9 Jun 2026 19:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781034857; cv=none; b=tgqcIO9xrUSA5ZlipSURqMkDKIhPmnglE/EJ0/TsVpaD/VmfYLIr1JP1mAJTYh9rp6+n5OFVq6+myj3Zb1fNgJPx2qEPwNbRGVqgvi9fYvI2H3GzydhaftVrDkoMsVzT3kbyhex6E6+8WFqYTICqJRWyyVLrU+gAPbqhFPsKEmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781034857; c=relaxed/simple;
	bh=TkaWFvSM6RyZrxUqK+02jv3D7cQIKgZRTwhbtgg1dkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CPJLGUQHzyQtCL6/A3S3hFoWalD6f5bPuj2KcnMabfUWkicw4D7WZcM0mQcFo9DcAm/6QcRUD9psMcyq7GlzS3CvG/HiCEX2C+Bh9CKBt1ZMhwlcGHUznaSCPhxqCdnI+rGTE12614QqdP+psZXUbORby7zNnjC43ku0Ou2MccU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JTGFSfSN; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mygTeC2u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JTGFSfSN";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mygTeC2u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781034852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JJYRstItJSN50oqy/Ac1ulkKACubDQSvXFZtdF0CG6M=;
	b=JTGFSfSN+bAVLQzYPuhpi3zLNtLLz/SCxRqnIi3ewWC0pnES4GuwmMulxe9Ebq5B7X9eFc
	JyfPCm2W44WtKyrvRgXu+eh8U8DgQZtqzSICossYBsWHDCILAsQ0OOisuuNXZuQGpVKnpp
	PBqf4uVXTUZDxrJv9BmAf+lfv7M6Ni0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-_D53AjS1PmCmtVNvWkPiJw-1; Tue, 09 Jun 2026 15:54:08 -0400
X-MC-Unique: _D53AjS1PmCmtVNvWkPiJw-1
X-Mimecast-MFC-AGG-ID: _D53AjS1PmCmtVNvWkPiJw_1781034847
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-460153ce644so4459730f8f.0
        for <kvm@vger.kernel.org>; Tue, 09 Jun 2026 12:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781034846; x=1781639646; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JJYRstItJSN50oqy/Ac1ulkKACubDQSvXFZtdF0CG6M=;
        b=mygTeC2u5j8LZWYScebgCwO/NH4RzZ6PN7eqj++qs6EmIiDux0MtYalgKNEhNzzIa6
         bXObRAVzagZ0PXOTV5iQDA3cH2leJghZhkumz8uW9zO0Tu+tAdKfwABjxkJKQEn5c6TD
         YOnD/eGBZ1j+KRUd7H9GgmVzxa3Ft9SEYHNhHkNpwTQVJ5bRnNLcxB5eLBCNqt8xiSzg
         T1vAi7PCdiGZ2UM/H4BxAzjQQ2Lufp0eywpW+UZB6n1lYfMrgqW8SrBn1qE63zDvA/4d
         1lZNuZQkEEvRH380SZDNWZz6k/swK8ENr8X+GANVugNHV3LhH/ORh/bAlrGp2KxuPGXD
         2CCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781034846; x=1781639646;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JJYRstItJSN50oqy/Ac1ulkKACubDQSvXFZtdF0CG6M=;
        b=fri+5STo1WX8oz2lq+ydzxFCLRooBIu/DM3vZs9StC4xhsoMsdIL9koEy33CjLjw1S
         OuxxeZSxm5NcxgQWxZA1Vt3wPbX1P9PWoGN/Gz3agQPSkcDF9rj+UtencO/gIQoI7Pis
         c+nXZrhmRQliE2GhbL5Su8sNaFOWuddlLmn5ikYez2taTmDLk/HEXxRyCkUA+aovJYSl
         uKLbVle2TLzRGf4LQMoldPjMxSBUeRMDbwRnT+a9Ja94UBBG0WIYW9yPMHHtVwMIKdJk
         IZwogjxj2+Lgx46TauxmkgHLFQRTqcDgBVuC0Gob2aWp4bWGwmo7rTboSooYMRrmQ0sW
         NlVA==
X-Forwarded-Encrypted: i=1; AFNElJ/hBipMutTOVNrGRaoWjbgR85AuZpNQlEBhFFnFM7LqlmGYS7QoXozv+vW+eJdN+4qLLfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpMxGlM1aVBWTJxdSvULl4vWraE4lsG+uM28/0lELYzJnef9QB
	QBGFXyI94aQmUuHFeR2MWc3TLbUPONy47gqibfoGWGzcxgguyHC7t84azJNkQhP79PaRJ7G5ftM
	6Xqs/eGq3Cvet7YsPIwZq0FHw1gEDPBH/6PyeaMkHag3n60buEQga9g==
X-Gm-Gg: Acq92OEppqRqfvnrRTAti691UEEAjpZrPfm3qV7DruoNkAECVFGcyBPwMzQlYDZteDd
	zQvisRoANoOyMsqXSiPbwZiKEUDTlnA7+GwJOWBeulj9XDuQdT+MObfi8kB+qIzL+6U1YW9Xigy
	IkpQsJXOC7hNfdWset3254WahKnhQyARhIynbSJHFJWY9B4bZZqRjLt2Me4b/FLQwIDdJQVH4PJ
	hTeL+MSjlai7HeCLXPCuOjIpDcu0Bd1dOtb28e2hXrNtUWp/Zp5kpxGKdFo+HkGoy49WU+ilw7+
	Tm9v4EVntQObiJrH9yBlUKAy3UrkOxiuuF31P0xsvgkE+8MgQbhoGwSRZe6sD4115qMnTDspA1F
	M4u5IAdIz1xVvzlI8LTV3RA0LuacCCd2hx7liVj7jtticVZ2gVVLIkg==
X-Received: by 2002:a05:600c:8b6a:b0:490:bb19:b110 with SMTP id 5b1f17b1804b1-490c26216ddmr332896585e9.27.1781034845719;
        Tue, 09 Jun 2026 12:54:05 -0700 (PDT)
X-Received: by 2002:a05:600c:8b6a:b0:490:bb19:b110 with SMTP id 5b1f17b1804b1-490c26216ddmr332896135e9.27.1781034845160;
        Tue, 09 Jun 2026 12:54:05 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3c183asm511355045e9.6.2026.06.09.12.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 12:54:04 -0700 (PDT)
Date: Tue, 9 Jun 2026 15:54:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
	David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Shivank Garg <shivankg@amd.com>, kvm@vger.kernel.org
Subject: Re: [PATCH] KVM: guest_memfd: fix NUMA interleave index
 double-counting
Message-ID: <20260609154046-mutt-send-email-mst@kernel.org>
References: <0eff0a90667b900bee837d06b5db5025e1f304b5.1780501924.git.mst@redhat.com>
 <178102235481.2735841.1203781071933134475.b4-ty@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178102235481.2735841.1203781071933134475.b4-ty@google.com>

On Tue, Jun 09, 2026 at 09:31:29AM -0700, Sean Christopherson wrote:
> On Wed, 03 Jun 2026 11:57:33 -0400, Michael S. Tsirkin wrote:
> > kvm_gmem_get_policy() sets *ilx to the full page offset
> > (vm_pgoff + vma offset).  But get_vma_policy() adds the page
> > offset on top of *ilx, so the offset is counted twice.  This
> > causes NUMA interleaving to skip nodes: for order-0 pages the
> > effective index jumps by 2 for each consecutive page.
> > 
> > The get_policy vm_op should return only a per-file bias in *ilx
> > (like shmem_get_policy does with inode->i_ino), letting
> > get_vma_policy() add the page-offset component.
> > 
> > [...]
> 
> Applied to kvm-x86 gmem, with a heavily massaged changelog to explicitly spell
> out that ilx == interleave index, and to try and explain the role of the index
> (it wasn't at all obvious to me why using the inode number was "correct").
> 
> Thanks!
> 
> [1/1] KVM: guest_memfd: fix NUMA interleave index double-counting
>       https://github.com/kvm-x86/linux/commit/48dbe4732198

Thanks!

Sean, what is your take on interleaving for guest_memfd?

To the best of my understanding:

Right now IIUC kvm calls __filemap_get_folio_mpol which in turn does not pass
the index to filemap_alloc_folio. That uses NO_INTERLEAVE_INDEX, so
MPOL_INTERLEAVE uses the task's global counter - effectively
unpredictable placement. This looks like an oversight (the index was
available but never threaded down), but it's been shipping since 6.19.

Should we fix it to use the file offset instead? Or GPA? And if so,
should that be the default or does userspace need a way to opt out of
NO_INTERLEAVE_INDEX?

Thanks,
MST

