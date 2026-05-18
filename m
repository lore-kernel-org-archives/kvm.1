Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D887640C5BD
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 12:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779107583; cv=none; b=Ptceqt6WGBgREQwuTuVDl8B7xsRH7TotdwXcMU8X4tqaqBcRpqMAKLJKakrJmJecmV7N2ZimuXFcHd6/bvh4+Uxzlnph2vlXYTOCsEqVsht1zSnw8q02SLHRRz0D5B7HMG3XfD4kbdvqLAR9iJhuoQBbLg7wybOomejxPCou+Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779107583; c=relaxed/simple;
	bh=C9Xw7GTZRh0407yOk0pU4RmLBCi7oFI/awd3tEWoV0I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EKsCfBGGkhYHaZSKNdW06bJQ2cA1ClQ7wPh9IMhkHKsSeIkvQPaNnCvZwjxEG/JxGq3HsFkaXAn2TAbGzTOjQW4Bij3SMXUiiniBj2uovkqv9eXPjPoabLo6axxHj3jKBG1G+5PftbwdPL0YaXTO7oL0VZZZPkwoL+afY5rLOjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MJ7WZI12; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=d6jrBwa4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MJ7WZI12";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="d6jrBwa4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779107580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0d9WvjLb1PfQrsdDdFrwKtnYPXrqYOrQTlHYnGHntbw=;
	b=MJ7WZI12A/VTlSXbagel5TG8G0IGyiqKurCtwLc3rwJ4BASC7HyuDFZvRKI5mNdsaNA3dL
	eq7aOajYrx4jT0+rjqRkOvGOf3BnvgmaY6C2RL442QG6ZA5H47d3o/ezPbV9I0sBdiCjZP
	k7tMc7CZspmQ+UlQjox1RbepxO5wOEg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-nu2cuhP0NaeN7l_3E_ICMA-1; Mon, 18 May 2026 08:32:59 -0400
X-MC-Unique: nu2cuhP0NaeN7l_3E_ICMA-1
X-Mimecast-MFC-AGG-ID: nu2cuhP0NaeN7l_3E_ICMA_1779107578
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48fe3e73da6so10648175e9.2
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 05:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779107578; x=1779712378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0d9WvjLb1PfQrsdDdFrwKtnYPXrqYOrQTlHYnGHntbw=;
        b=d6jrBwa4asUhM8wuf4yMnNRxeMNPPfkoTqqpmlYJ1lekSEsZE8DHPoCVyeU+K6FP8w
         U7kDz9rnmbRjfAHn6GlCTtm+zjfvnKseJqUKthpk0/8v765mSSlNj8lcXXqBBbcBLJm7
         YHlV6KebdwOMCVQWJWE+oQy7hHG3GOzJtq4kag0RkaCC/RgIMXNe4WSOvhdE+nJr+zRY
         VGCSXm5mHe/DYKaF+RM76tTod75GLJbYWrlxBowMyXtYhP7SeOBQV7d5swXeq25YZzsg
         f9Jg/L7OWUt1mInfCH5TtZ2t20ADE7kZKDNHFrLadR6KdG9gXqw4KQBTXl4W8DCCjAkt
         Rs5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779107578; x=1779712378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0d9WvjLb1PfQrsdDdFrwKtnYPXrqYOrQTlHYnGHntbw=;
        b=bdEUbQuXhQQhQDNvMr2ZZHttvaKSqtdofWTDSIaKzt0u7KoYpA26Tt7D+o3ANIFmtj
         PXfDiF/IAHPX7DFGYRqe/ageG2dZ7GSttQOG15OFEo+P6VP5nNUh8hSJzgp6Oq/7NfX/
         yr8WkpUqTXbu6o4BS+4+Wv0thyWd4URdTyzuVrS01LpgEEglF+3zxnnqTs9hxnTGK8TR
         /F9oRVlNmecjXFSWz0Hdr6+miEdlyycGyTFCJGg4foniejtIpIPBBeMHNN6BqIMXtn5V
         Xg8Y9xAdbVaMvtZlwHjU3sMOPoeMGZF5YBev52+kPwKK1oJoRWYO4wocIIrnwq4M6DCT
         zn3w==
X-Gm-Message-State: AOJu0YzsoJhvAjVvp8F08DBUBwS/4jiDrEtg6P7ecVotjvJlOYAh7urE
	jwYLCo0ih7uncKLpy1H2D2DsU6zEaCa7o7gSPfG4M+Ac3w7ayjwI17QX0kMpCQ18pLf8S/aMPIs
	krx9dVC1kKIcyLtBd11uUtVEtZB7kcJ/7xLU6g1HP/duyEgko6qyPEg==
X-Gm-Gg: Acq92OEEChouDdWMCox9WPe7ptOxRL85HLBsTdpEwYqkxFRbi+BR/Ovv4cW57f/I/ma
	aiRIg7G/ZfhYoyG+Py3GEAm+ZGb+5nGTn6PtW6A7jf0tXq23dY8XQHiSrzwlKvqSHBz5U3+m+eX
	r2jkeLIe50oVwm+TlWwO2eUWH+jbbo7EmoU6+Ed0yWlyIviGpagM6lTk0O3zq0ktYwwocu0tx8H
	H8ZKovdwl9VX92ssNN+0UMIRzkSbNN19fo/JcbvRYU6fKxmQ2zagwW4nDa94c85ZAi5/0DPkDGg
	xfR2ECx7+opOcBxhMRqmOcc7tshhGW4rZqsNq16cOmo38GcJfBh+iHt8/R1KHWfcFkEgiDI3xsM
	xJiURyQ==
X-Received: by 2002:a05:600c:c10b:b0:489:1c2d:211e with SMTP id 5b1f17b1804b1-48fe5fcdedemr175576165e9.5.1779107578120;
        Mon, 18 May 2026 05:32:58 -0700 (PDT)
X-Received: by 2002:a05:600c:c10b:b0:489:1c2d:211e with SMTP id 5b1f17b1804b1-48fe5fcdedemr175575905e9.5.1779107577705;
        Mon, 18 May 2026 05:32:57 -0700 (PDT)
Received: from imammedo ([213.175.46.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febe67688sm101577515e9.5.2026.05.18.05.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 05:32:57 -0700 (PDT)
Date: Mon, 18 May 2026 14:32:55 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, babu.moger@amd.com
Subject: Re: [kvm-unit-tests PATCH] x86/svm: work around Virtual
 VMLOAD/VMSAVE bug on Naples and Rome
Message-ID: <20260518143255.3795625a@imammedo>
In-Reply-To: <agcVNezX5lf1_3O7@google.com>
References: <20260515111957.4188366-1-imammedo@redhat.com>
	<agcVNezX5lf1_3O7@google.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 May 2026 05:44:37 -0700
Sean Christopherson <seanjc@google.com> wrote:

> On Fri, May 15, 2026, Igor Mammedov wrote:
> > AMD Family 17h models 0x00-0x0f (Naples/Zen+) and 0x30-0x3f (Rome/Zen2)
> > have a hardware bug where Virtual VMLOAD/VMSAVE causes spurious VMEXITs
> > on VMLOAD/VMSAVE even with intercepts disabled, when the VMCB physical
> > address as seen by L1 falls in [0x78000000, 0x80000000) range.
> > Reserve this range on affected CPUs so the page allocator would never
> > alocate the VMCB there.
> > 
> > Given that it's relative old CPUs + nested env + only performance
> > impact, it's not worth fixing on KVM side (which could involve
> > messing with allocator or reallocating VMCB, until it's not
> > in affected range). And since test acts here as L1 it's not possible to fix
> > issue in kernel (L0) anyway. Hence a quirk here, to prevent tests
> > failures where we can't do anything about them.
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> > CCed: AMD folks for awaraness and in case they would be willing
> > to look into fixing issue on CPU side.  
> 
> LOL.  Don't hold your breath.  According to AMD, Zen4 erratum 1454 is a firmware
> issue.
> 
> https://lore.kernel.org/all/20241105160234.1300702-1-superm1@kernel.org


The might decide to nuke older server EPYCs, but until then ...
I'll add a few folks from that thread on respin.

> 
> > there is not official EOL dates on both, but using a newer
> > generation(s) release dates it appears that both are effectively
> > discontinued for ~3-5 yeas
> > ---
> >  x86/svm.c | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> > 
> > diff --git a/x86/svm.c b/x86/svm.c
> > index a85da905..706ff2ef 100644
> > --- a/x86/svm.c
> > +++ b/x86/svm.c
> > @@ -334,6 +334,21 @@ static void setup_npt(void)
> >  	__setup_mmu_range(pml4e, 0, size, X86_MMU_MAP_USER);
> >  }
> >  
> > +#define VLS_BUG_START	0x78000000ULL
> > +#define VLS_BUG_END	0x80000000ULL
> > +
> > +static bool has_vls_bug(void)  
> 
> Probably need to be more specific, because there appear to be multiple flavors
> of vls bugs.  :-/


would something like this work:

-static bool has_vls_bug(void)
+/*
+ * Naples (Fam17h/00-0f) and Rome (Fam17h/30-3f) cause spurious VMEXITs
+ * on VMLOAD/VMSAVE when the VMCB address falls in [0x78000000, 0x80000000).
+ */
+static bool has_vls_spurious_vmexit_bug(void)


> > +{
> > +	u32 sig = cpuid(1).a;
> > +	u32 fam = x86_family(sig);
> > +	u32 model = x86_model(sig);
> > +
> > +	if (fam != 0x17)
> > +		return false;
> > +
> > +	return model <= 0x0f || (model >= 0x30 && model <= 0x3f);
> > +}
> > +
> >  static void setup_svm(void)
> >  {
> >  	void *hsave = alloc_page();
> > @@ -413,6 +428,13 @@ int run_svm_tests(int ac, char **av, struct svm_test *svm_tests)
> >  		return report_summary();
> >  	}
> >  
> > +	if (has_vls_bug()) {
> > +		phys_addr_t addr;
> > +
> > +		for (addr = VLS_BUG_START; addr < VLS_BUG_END; addr += PAGE_SIZE)
> > +			reserve_pages(addr, 1);
> > +	}
> > +
> >  	setup_svm();
> >  
> >  	vmcb = alloc_page();
> > -- 
> > 2.43.0
> >   
> 

