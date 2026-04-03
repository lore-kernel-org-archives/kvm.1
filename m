Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E4954726
	for <kvm@vger.kernel.org>; Fri,  3 Apr 2026 22:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775255518; cv=none; b=LaP+AxohtPi+lhTT2Qtq4KGFLGIyCH9W9DYasCluncR/VvghQdTJK9TXyhSDfSLmIM/wFyuM8ERQmBA8AR5OchMBsyUBkeZSHi/Em/nu2qDD3DiGIZRd7EVAnBPJlEFwj0RW3V7t1Ll1FwIZzwXthcN/rtvz9mdLQnVfErUrPpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775255518; c=relaxed/simple;
	bh=dCVzQ+2ZUEgOwhHEP9zxfIHH7Fby5pavu1Gyb7oLnrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QKODzAenatkBelB2NHg8nnCiKfEwag36OX6q/xhk7ohHCjfW1+b8bbh8d4ib9wuoXMHrc+9j7pjHdlgEMRW4x5XvmihDAPOeU9M0UpLpZ/qdZdjiCX6v94LUwXQ8teEvJH24ikX6x2vKnOYEPibHnFm+Yo+/AzA4O64JJRz3N0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fnl96WYQ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fnl96WYQ"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b243198058so90795ad.1
        for <kvm@vger.kernel.org>; Fri, 03 Apr 2026 15:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775255516; x=1775860316; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gjuoZin8EjeumwxQWlEEfcXBzhIlUZuPBzNuCTkTKsY=;
        b=Fnl96WYQHI0vaHSFjk1B+hqs2hRck16LZwarfzh7rYx/cpXkEM4GGaEMtvWvXlvURz
         aohRsJuDqRxTvBWb3UW9jGchKhYCs3eU2eI5KQFgtjW7RQqXlfIoJ/dxl75JiFyMDnFf
         dJjoJCqswTzuTAfN1AqwGLyJmdL6wTkLOlER7C3havvCUgBeixJiBWb9ZafyGyv7az+w
         kFnYIXUJDuknWODrDpc1qcMi4YEFOThlmTg+9qgjz9brbi5gWpWFqpMcZOMpqh3b1ka8
         Vtyv107jmbL3kDfXlKLLd78rxain8Bzy1471/tiSiDl3vi8k6K4N+l/7F42jeQkhiK9y
         JCPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775255516; x=1775860316;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gjuoZin8EjeumwxQWlEEfcXBzhIlUZuPBzNuCTkTKsY=;
        b=Hem945X9W0PnmmFnIR++YyYnmAnewEKh9J79qIkO31fidtqXTxKHMER9hs6L10eaNR
         Mxbq2+WOSHnelfcvZ463+H5OllhSra5UdNM8Li7x4j3TtY+zfbKXYjC589beOlICvl2f
         tzN3kxIKK0sjthf6l84Tk688xC93CwPz2UKIB6gue9wFE+MoAlhAyrjgjsDBbgMY01bF
         7mB8yirYhwAJAORNJTNn2QF6opwdFs+8w06T/6EDbQtaXucuWrasgjr12VFRUmoESulf
         eA2HKkzB2pnyqDnocQDOMUI651uMUFlm8SKMnvde6fKgPqwSP7XV7JY1ydAjuRQveu2l
         mtmg==
X-Forwarded-Encrypted: i=1; AJvYcCVTSxw0uQTIBNGJOkf3FjrQaN/9aIR0NJG0sflSlFxwT4IWSUZ4DsI8rQCICmPVt0b4Wyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKiF4TZuSxrrgqKqEWT8jJPIUdZj+5Y0DyAj/SAjlToMGtmm2C
	JlSmfG0tYNysNjqPcrCRwz1wP22ihvFdCMZ4VeXdlvbJTEIFDh+V86qbP2s7EpTJgg==
X-Gm-Gg: AeBDieuujjoWD4W0v4IKTpJpqRzqmCamv60MYhGqq1lbL4a5xgvM8nf1VZfdr7daKvq
	GgTJAacUwreKh5W/dHCBdvonA5QHEAXXb4z5D35UzTNq0YvOX35pQ/SjsxUOV04Vt1/Ar/2SMmd
	kWTSzUH4c12JW260F+j/jhUkERnTulGMLk6+/nS/FGl5k5TyJAnBGEj5GpDQMjLIs/mfAt3cFsS
	BaGVVH1CSUHfUD3cYWCyGh0+J9xvANaXkHNUn9jSMbo+YbMUDQ77mGqXJqc+6JKk7WD8lyOE2cG
	GWhu+S17DvBMFigFhAhEud/TMZJJvvRdhnjocZeoGlJXJUtYV4Q2RD0uXSvuhY15HRmPQixQ+nq
	sY0RLxV+PYLx+V4MjN/1VVUH1hcbRXStk7igvs3MpnJxFWFrjh2rjqLTs+oUZKI6ATIrX3Mka33
	Re53PU+K8iMY40/i0w2MRvs7I5GBLsllxXBv16wkTKGi9QZLGn25EnBBcnmwFm66cI
X-Received: by 2002:a17:902:da87:b0:2ae:4453:3674 with SMTP id d9443c01a7336-2b282ed2eddmr3770265ad.4.1775255515833;
        Fri, 03 Apr 2026 15:31:55 -0700 (PDT)
Received: from google.com (115.112.199.104.bc.googleusercontent.com. [104.199.112.115])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe95abc3sm12613068a91.15.2026.04.03.15.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 15:31:55 -0700 (PDT)
Date: Fri, 3 Apr 2026 22:31:51 +0000
From: Lisa Wang <wyihan@google.com>
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: rientjes@google.com, seanjc@google.com, ackerleytng@google.com,
	vannapurve@google.com, michael.roth@amd.com, jiaqiyan@google.com,
	tabba@google.com, dave.hansen@linux.intel.com,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC v2 2/7] mm: memory_failure: Allow
 truncate_error_folio to return MF_DELAYED
Message-ID: <adA_1zXLUBqmSHFl@google.com>
References: <20260319-memory-failure-mf-delayed-fix-rfc-v2-v2-0-92c596402a7a@google.com>
 <20260319-memory-failure-mf-delayed-fix-rfc-v2-v2-2-92c596402a7a@google.com>
 <2f177e0f-2eb0-48d0-b48c-7a0a340caf5d@huawei.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f177e0f-2eb0-48d0-b48c-7a0a340caf5d@huawei.com>

> On Mon, Mar 30, 2026 at 03:02:01PM +0800, Miaohe Lin wrote:
[...snip...]
> > --- a/mm/memory-failure.c
> > +++ b/mm/memory-failure.c
> > @@ -941,6 +941,8 @@ static int truncate_error_folio(struct folio *folio, unsigned long pfn,
> >  	if (mapping->a_ops->error_remove_folio) {
> >  		int err = mapping->a_ops->error_remove_folio(mapping, folio);
> >  
> > +		if (err == MF_DELAYED)
> > +			return err;
> 
> Will it be better to add a pr_info here to provide some information for users?
> 
> Thanks.
> .
I think we don't need to add pr_info here; truncate_error_folio() always
leads to action_result, which already logs the recovery status.

Lisa
