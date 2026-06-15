Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F5538B131
	for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 19:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781550538; cv=none; b=iRFTWh25YkuRN959tg6fFc96VhidYe+jlZDCmfxY+ip4nPOFUuYZMpV95hqJ8BNcX7AGZFlot4KOCxH3BFn6DIPWofwVkhc913zgVhHMb0nVSYTBXzmfTOAKKwln6JqLvVXgANnkysR4UCGBJF0/qdZB0qcYh7Lp94j9b45RDKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781550538; c=relaxed/simple;
	bh=EvoJ3aDtZ4F/C8Kr9wphawKCAyi3l8ODysFcMsfBdGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OmlVeIXzJaRLwdaSlp9ODCPmgsESFWfUmzk6zIi+3do1MyRD97e758QWBciF/OeqQV4xhMtwUnXGBLMzwQZRsoRWBjsSFU60i0IMyv0MKTsbxW5Z2nm3Ycw6SVEp1WWI7MYtiHIQ//HZ155Fk5u7dViMXx7dPcrLGY1r13JtI7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ETarz34O; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ETarz34O"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c0b1a48855so11595ad.0
        for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 12:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781550537; x=1782155337; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ISqMLHuxmmME4HG1iYeuq/aT+EEs3k5ypriNOeJFwpk=;
        b=ETarz34Obq789inNl2pics+fHINA3Gx16qKzeiY9T0eqGMZQWo4H/n9KfwSxzM2PC8
         Nz/2Ac8IgJa3RMZAOr6TyNnmPd7lvmNDxFw8c314bfo1cl+DKZU9rBV1T/s7VheYrJ0l
         g400EEgReNo7S/Ox7a5MtRjfBoeFei+GKjSrGmebvtU0rKO4oHoW0Y8O9LTpLGXXtwKH
         2gMsGKDGFagEyeQ/2TmC1XjCRa/XkK4MkRgsSN2lxP9s1ZlnAZnE5HAhiWFss8E7L8pG
         9il3rn9l41D0SvO2AqquwEXml3fxtzzj/Ym6TcR4l/fFm5GkWb+6GkFRCuiu9dJcJKce
         87lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781550537; x=1782155337;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ISqMLHuxmmME4HG1iYeuq/aT+EEs3k5ypriNOeJFwpk=;
        b=MbBctYVLFKHwy61NRCIm9EqHrA/3xut49OpBvXYHRv4DlaOABzVegxH7MTO9hd7Anl
         B0tNaWFZkoJP3dWarzSquO+bCGuEa2tRH01cFffIFfFTK2V0oyU0nMh+s+HsqO5bcdk7
         UwauJ/a8WkQ9na+jjLsG5/JYFLHlRQKDuUVCfa7NI7MEnC5gtNWGzCVQEXg/A6HgwvLE
         KA4DZpt4bWJ2JHiNIZldpzumeSdAzeFuEzL1GRedeU7gJpxI45Z7e0eFIAWjcsicFlr7
         3tl8YZ4079VpBTP5pf3J4JGG5DfT4UuJHq5i80+dHlBzB1uSgmZktbiFonYR9GF3dGBO
         tRHA==
X-Forwarded-Encrypted: i=1; AFNElJ9bCfhN1GcJviJtBgTCOGYPxA+1h4VcuM76yGnSx5MlaqspEhedg8xNQbBz/CA4z2m9M84=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb9PrpLlD6zWFl1fLgejIW7Cow5+J2uVv2Mazc6noDWuv7KbEv
	16fEaKpg+wnQMnQSh+VBrnWfCPVC2MJYeZ0j8wHkxMoq9CJZSQguEX0uuKiLZKLNJA==
X-Gm-Gg: Acq92OGLRAqzmSaYL4dbiTuRJStfA4QYc4nkKcb7xeDNUX9yHGt7PY3lH4d8T/Y7ZZ0
	i7pIFE232plTjgFRwjPFUMeSySjsTsPcUOhvLIBxEc6yyu+e1pbhI8ym2YIVmUQSAf301KwRctC
	2r8emHNAGDJBlcWfhRSSHoqEBN+S7vK3ACIq/xScz8O/v946klwM1ZQKE4MYVKb2Z0Wf7K31Q6i
	rHewYjMm+nWMUJiNEQzwlsfpW5SDNVancbYIwIcUVc0BcfGmdNzAqhTCI01vuNThuhp67J1xb4n
	s6wsrHVgLtAOZoNVGMqjuaH0f9nznk/nmxw8oUZXyKEplGyjZCD3gDKUCq5+zEqAjMrYLZyj+SN
	Nhw7JqpqgRJiL3Bej3fS8uf/w1N+Fg5Y0Ru/bXtWCLcqWmImMbHmHhaNXhgXDnWBQ3VG/Zh4iE+
	7He6D9QNwpikFRRi6hHu2/w73b3AF+SfSdBbGigLJo3jXz9zFFtRD+t+AgXEg=
X-Received: by 2002:a17:902:d584:b0:2c2:2485:7086 with SMTP id d9443c01a7336-2c69a3f43e7mr514035ad.17.1781550536841;
        Mon, 15 Jun 2026 12:08:56 -0700 (PDT)
Received: from google.com (62.101.197.35.bc.googleusercontent.com. [35.197.101.62])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37c5228ebadsm344889a91.10.2026.06.15.12.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 12:08:56 -0700 (PDT)
Date: Mon, 15 Jun 2026 19:08:52 +0000
From: Lisa Wang <wyihan@google.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, rientjes@google.com,
	seanjc@google.com, ackerleytng@google.com, vannapurve@google.com,
	michael.roth@amd.com, jiaqiyan@google.com, tabba@google.com,
	dave.hansen@linux.intel.com
Subject: Re: [PATCH v4 5/7] mm: selftests: Add shmem into memory failure test
Message-ID: <ajBNxPKzhARLFk9X@google.com>
References: <20260602-memory-failure-mf-delayed-fix-v4-0-a5bc7db5a9b2@google.com>
 <20260602-memory-failure-mf-delayed-fix-v4-5-a5bc7db5a9b2@google.com>
 <6963083d-6725-4081-b2a2-894a0510c6fb@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6963083d-6725-4081-b2a2-894a0510c6fb@kernel.org>

On Fri, Jun 05, 2026 at 01:38:28PM +0200, David Hildenbrand (Arm) wrote:

[...snip...]

> >  static jmp_buf signal_jmp_buf;
> > @@ -165,17 +170,21 @@ static void check(struct __test_metadata *_metadata, FIXTURE_DATA(memory_failure
> >  	case MADV_HARD_CLEAN_PAGECACHE:
> >  	case MADV_SOFT_CLEAN_PAGECACHE:
> >  	case MADV_SOFT_DIRTY_PAGECACHE:
> > -		/* It is not expected to receive a SIGBUS signal. */
> > -		ASSERT_EQ(setjmp, 0);
> > -
> > +	case MADV_SOFT_DIRTY_SHMEM:
> >  		/* The page content should remain unchanged. */
> >  		ASSERT_TRUE(check_memory(vaddr, self->page_size));
> 
> You should likely use "fallthrough;" ... unless you are missing a break; here.

Thanks, will fix this in the next version.

Lisa

> 
> 
> -- 
> Cheers,
> 
> David
