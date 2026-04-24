Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4B223E356
	for <kvm@vger.kernel.org>; Fri, 24 Apr 2026 13:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777037828; cv=none; b=dqwA3K8MysCmCXgLbu4QQ6sBf/mmtv8fIzjEa+Hxz2mgCfTdpjdUFJDqO09NHnMY5fHwgaXkvBRc0H+j3juE1l3K6cEt1ohZYflWUpHfg1vKU2TlaxddxejkGd1gy15eCAWWJLGBFmB3guNkHYFULkEPvMQkMqZNYGJDWyQRXgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777037828; c=relaxed/simple;
	bh=BSx3qFPNO/NMYwuSHNZB31nKRkS0Y90uuNokhVUvaPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qGK9boRx2/8TjHbcuffCU9ri+Wf1Ulm1xhJXHAyJJfN8OJ9q/5rQPr14XATDT6gPoDYXV3qEtm9xzl8sAf/6Jg7HzQIZIcjzcNBWdoEmGN2D+l6mlCl6dO/qeLZjpy+HS3py70NyXDYw+7r878Id+3j9TK0X0iaB5Co+a/5zSuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=LmX7ETwm; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="LmX7ETwm"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8f231f3b130so88746185a.3
        for <kvm@vger.kernel.org>; Fri, 24 Apr 2026 06:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1777037827; x=1777642627; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uWWbj/VPS78zqXVF7C00n2rbNCSFE3WHczyNV5IMoNo=;
        b=LmX7ETwm+ZO/lr2eJaaaoYplLnQ67tHwdCp7kA0z1dX7YDpyOrIynIrIR5l/s9nRQg
         cGQrPUasocBBXobw7LDy2Mtqk/VzTQr2g5S8LTKm9X6GOB3cZhUCNr+Wp1EQnc3mpPPu
         ZJMDUgLmqQX8t5rX5P4AGZhG1J2EUVnNHN3AEp1mNbBEauM1CO7uJ9TaEZGzQIllpUYO
         LXRSFEeg3V/M/68OF8DvwD8mWRwTBBOlFGDKFh0hXUxRuJhp0jvZjix4bTlph0c1Vggd
         X35XsAvgC7lvP4sK4qLjqXK3GZAsqyQDmjhgYSzRiRuPVE9JBNPlFuyQhwCvL8uEqrff
         RNbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777037827; x=1777642627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uWWbj/VPS78zqXVF7C00n2rbNCSFE3WHczyNV5IMoNo=;
        b=pifNByvI8ekSTaGwonk1KVJjSlvy8jsy3d91AFIimPWC0owpcmI3MvI495gfgclStH
         xw6skIS7wEssluIWWo9HvJea8B08zEzV3rzte5b5hPVuobhPxPzC7HYsC2zRgTZj+Ii5
         9vDiPaMzDPopVW9+RdrmJh/GwO9KOBy2l5uiy6hB7gH7p3f4+qFR7mMvRtOHQqU2zS2Z
         sFFJ2uLIw3Nu9mLtyarXzBPcl1hiQYBtdYXEJEPA5qT41TMDVsGOxh/StR7RdoI16nCp
         FgV0aKojvIizxjSOXji9ifTKci6usO/Ivsfve3F0XTfDwInuQXBUhB3JimlvXDtD8QTC
         3eiA==
X-Forwarded-Encrypted: i=1; AFNElJ/qoUMO1foFPRHeBQ/1V0aYcFhosqZcCWPS/X2nw8aRlB2ppZ7a6FyyrEpCpCwOMZqSik8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXzjIKMwhI/fPwSBkbMv/iYkELCRTNdQJwa7UySPOyXP/113J+
	gaEoOaJu9gqoZ/riX66JpCKGD8lB2vshdtu+HxSOU2vtvkUBuNzSaIMRmTn7CtUoKWU=
X-Gm-Gg: AeBDiet639nh4RpwBhMSaiuMawtGiv0m1z0nc83yvbA9RzsOOqUgNcesSiBp32vzTEZ
	3i70cXtUgGyjG7d2WGi/TJlNGRa5dWmFCeWX/M2NgSQFh/NsyB+rop7oMa8Jx5yiZ9dwAcWbx9D
	jgRDhsZhErQBILoHRibLiI/3/d/QyonTQJlprvJBp4+J0WYpeo6Bre8aGrkluAP+rUPBgFw2Gj3
	Y3viPUtZaOnuzKk30ZBWQHPXOf688qKDLJXF13dpSOD0XoxfeYN/CljzgJwoChDZc0JKDnF27IN
	VoGxlIqo5FAUNLhc75J2xoxnMhdokcJO/ANctB+VzK37x1kAC+nwhjUPviR7dfBwS3s3oHeOyl6
	8QVDzjd3xr0/N20A378AUgI25Gu3QmypMu6IchVih/AFXAw0ttjWYnalXJdGOss7OJGuW+TLkns
	3w1fKehxj/KZJESk4VEzSgm/P/OkuAarjgJntw4+c2bFILV6LtSYNhNqaRz8yIgQ==
X-Received: by 2002:a05:620a:17a3:b0:8d0:27b8:fb7 with SMTP id af79cd13be357-8e79246cd79mr4470598685a.46.1777037826446;
        Fri, 24 Apr 2026 06:37:06 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d5fe98dcsm1992846185a.7.2026.04.24.06.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 06:37:06 -0700 (PDT)
Date: Fri, 24 Apr 2026 13:37:04 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Lance Yang <lance.yang@linux.dev>, peterz@infradead.org, 
	david@kernel.org, dave.hansen@intel.com, dave.hansen@linux.intel.com, 
	ypodemsk@redhat.com, hughd@google.com, will@kernel.org, aneesh.kumar@kernel.org, 
	npiggin@gmail.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	x86@kernel.org, hpa@zytor.com, arnd@arndb.de, ljs@kernel.org, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, baohua@kernel.org, shy828301@gmail.com, riel@surriel.com, 
	jannh@google.com, jgross@suse.com, seanjc@google.com, pbonzini@redhat.com, 
	boris.ostrovsky@oracle.com, virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	ioworker0@gmail.com, roman.gushchin@linux.dev
Subject: Re: [PATCH 7.2 v10 0/2] skip redundant sync IPIs when TLB flush sent
 them
Message-ID: <aetw4aoABYj3keMh@plex>
References: <20260424062528.71951-1-lance.yang@linux.dev>
 <20260424063024.ce42ee6a5546e4d9337dd007@linux-foundation.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424063024.ce42ee6a5546e4d9337dd007@linux-foundation.org>

On 04-24 06:30, Andrew Morton wrote:
> On Fri, 24 Apr 2026 14:25:26 +0800 Lance Yang <lance.yang@linux.dev> wrote:
> 
> > When page table operations require synchronization with software/lockless
> > walkers, they call tlb_remove_table_sync_{one,rcu}() after flushing the
> > TLB (tlb->freed_tables or tlb->unshared_tables).
> > 
> > On architectures where the TLB flush already sends IPIs to all target CPUs,
> > the subsequent sync IPI broadcast is redundant. This is not only costly on
> > large systems where it disrupts all CPUs even for single-process page table
> > operations, but has also been reported to hurt RT workloads[1].
> > 
> > This series introduces tlb_table_flush_implies_ipi_broadcast() to check if
> > the prior TLB flush already provided the necessary synchronization. When
> > true, the sync calls can early-return.
> > 
> > A few cases rely on this synchronization:
> > 
> > 1) hugetlb PMD unshare[2]: The problem is not the freeing but the reuse
> >    of the PMD table for other purposes in the last remaining user after
> >    unsharing.
> > 
> > 2) khugepaged collapse[3]: Ensure no concurrent GUP-fast before collapsing
> >    and (possibly) freeing the page table / re-depositing it.
> 
> Sashiko questions:
> 	https://sashiko.dev/#/patchset/20260424062528.71951-1-lance.yang@linux.dev
> 
> (I never know if my Sashiko emails are welcome/useful.  Maybe Sashiko
> said the same stuff about v9 and it's all wrong.  But better safe than
> sorry!)

These emails are helpful; but, I do not believe you should have to 
manually follow up with a link to every new patch series.

Perhaps  Sashiko could automatically send a summary email in response to 
the cover letter, or provide a link once the reviews are complete. For 
the kexec ML, we opted-in with Roman to receive automated emails from 
sashiko.

+Cc: Roman.

> 
> 
