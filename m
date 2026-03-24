Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1408E238C0D
	for <kvm@vger.kernel.org>; Tue, 24 Mar 2026 00:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774313011; cv=none; b=UEQY7t7c+hmGbvqaJbz4e4+ZpGff9NPUghPtBtq7NSz7J0K5tRTm5LTF5vc1AvbqFN6oTQQ8Zim8vqpP9VdpDyp6VPSX1sAU2rFiQzLcDY/0rnlOvjIb5qTR6YD/qIUn+OZYdJiOdUGxjt9BxJwy7kziVfYOGDEIOJiq2qg/3aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774313011; c=relaxed/simple;
	bh=Ste15H68ky2srs+pxlgivQ7lOAwgK8ZcuTuVNMeNonM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HNhEc2y9CkdwnqsWlx03FcJLytHV2VnPXW5PsjbGMSht72QYor5O2o3oW8cXE78E90XXqmZAhhdppmabxIXgSXmK1+c5mBSApP8FHdf+59Q+N8kdzXlwGfDEVV4vpolBt2PMwy389QrQzDuVwA9BRZTF11bauNpvTnUluPvhsHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OX6spqsc; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OX6spqsc"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2b052562254so44365ad.0
        for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 17:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774313009; x=1774917809; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tP4PkIA/dAss1SYdem97AuKhuaCH6Uwc8eZQpSWtLFc=;
        b=OX6spqsc8zEzdZTScN6XzmhqW18eIY4YaB5188BdmSFmnztPwCfDm2cQg6O4FIvb6i
         CRcsijlJdCNK8dHL1uZJOzViHUyJHUFuXe9DgQFtQCAGYZhzVYYfHzCTtMki18vCjgta
         vgF6kpLClXsrguNCn4OmqCqWg/z4m5zee8GuoXV0CRUtA+Og/pidUJV+Ydf4jBUS+YjJ
         kmR6hpQidpb2gzOs8NkyJsZUPXTCsGTDdRIG42JkAO3zERdde9riyqaYop5m4goo0rSH
         qe4+vrAvV4p3IU6x2kriLDeVJxrtHg0BzamVwBVCdiB+J0qFCeQTylIcTymQCLRi/cLa
         opYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774313009; x=1774917809;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tP4PkIA/dAss1SYdem97AuKhuaCH6Uwc8eZQpSWtLFc=;
        b=MletXz6UV0Tl4qpBCjw2IcxRw9wXKn2YalFbfQn68Qb5jiaMHUB2rIgqcLrjxoz+8x
         7WuB8Q40g3zlYcVLXKgYkfMbPIN46iz6HWgXO6pFcRa7tqLoxCJXrBlJrbyHYbIep5zc
         NwZRYW7LrXtEVNB9g1s4Rm9u7J+hEy/IglA3Q1xoB5OdN3/GUYoNkr7xqyNXWGQOcGUq
         0gae3uazAH7+WPJ5PmBbBAVkC9nltGKSKgvbnxAOehEl+jtL3b5BGvJsdxMnF2r3ANxb
         KeUFY2F3Mm05Rz4PkM+aOENF2OOd8nCgJnO4MGKMdJIpJlkQmhlmS7/GL4wg8dS/Nc+c
         tdAw==
X-Forwarded-Encrypted: i=1; AJvYcCVPRcV5H+q/6KiCdrFuzIvvnTPv2IOM+P4qtFWJMd2gqZZyvqoM2Zwu+UPpKfZ5/48dTyw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfcaRqCA83pR3qtat2oahe42WGr+yGPj4F86/jdXmgZlKn6Ijd
	d7OV42legDQb+FpX5oF0K+gN8TyWvCckIu10/nKb/9z+f4E2EugJSjCIaBwPAbmjiw==
X-Gm-Gg: ATEYQzyrWUPgSlEqWDNG155WigoQPOL7CvtciNSZRHTvxMiJZ39lZUN74gl2+VlMmiE
	/FW38CBbvGT8XtgxRrpOzpaBfeW9rLuC6zmBNsNhqyBGcAqanxHuoFzdw66rmxrLgfCVUn/BTNA
	FoAum6gjv4gyzoTxmnjsA7vejINf6ulgcutV0O4J1UpCItSuXCx/tSETuyaKjxnMJMhb+I7/1xU
	KWmTNxQfbNQmnSKIWGvlIfxNEP9EtKCSXcKVamYMF3rDUm+NKfwBIB7RSy++oUOul+wBe6+OpRe
	aomSv6cmHDSP7xFMh1cROSG4uf+0DW7MoxfifuXapTgvwGTdM/wXRzJ3V341AIYhG7oPdX+dSDc
	5HWhO7nnqycc/iA2XzFVcT5UsViOSgXswTMh8+zRLSEWCmxah70w5h0NAZvt+jsWtHgdOAV9iVI
	YUVpZrep9dKPJBEedVY0XKafA58Nsw+vEZhKis9X1tdEtya7Dx48Z34pTMl2Q=
X-Received: by 2002:a17:902:f54b:b0:2b0:5b4c:a439 with SMTP id d9443c01a7336-2b0a5405594mr1757525ad.2.1774313008753;
        Mon, 23 Mar 2026 17:43:28 -0700 (PDT)
Received: from google.com (249.53.168.34.bc.googleusercontent.com. [34.168.53.249])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b0409c6besm12352073b3a.32.2026.03.23.17.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 17:43:28 -0700 (PDT)
Date: Tue, 24 Mar 2026 00:43:24 +0000
From: Lisa Wang <wyihan@google.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	David Hildenbrand <david@kernel.org>,
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
Subject: Re: [PATCH RFC v2 5/7] mm: selftests: Add shmem memory failure test
Message-ID: <acHeLL0l948jRchK@google.com>
References: <20260319-memory-failure-mf-delayed-fix-rfc-v2-v2-0-92c596402a7a@google.com>
 <20260319-memory-failure-mf-delayed-fix-rfc-v2-v2-5-92c596402a7a@google.com>
 <78a855da-8fc2-4e85-90a0-6bf9af030c02@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78a855da-8fc2-4e85-90a0-6bf9af030c02@linux.alibaba.com>

On Sat, Mar 21, 2026 at 02:30:04PM +0800, Baolin Wang wrote:
> 
> 
> On 3/20/26 7:30 AM, Lisa Wang wrote:
> > Add a shmem memory failure selftest to test the shmem memory failure is
> > correct after modifying shmem return value.
> > 
> > Test that
> > + madvise() call returns 0 at the first time
> > + trigger a SIGBUS when the poisoned shmem page is fault-in again.
> > 
> > Signed-off-by: Lisa Wang <wyihan@google.com>
> > ---
> 
> Why not move the shmem memory failure test into memory-failure.c?

Do you mean let memory-failure.c kernel code check by itself?
The reason I write the selftest instead of combining in memory-failure.c
is because
+ do not need extra checking code in kernel code
+ make it easier to trace the entire execution flow, starting from the
  madvise() down through shmem_error_remove_folio() and into the
  truncate_error_folio() logic.

Pleas let me know if I've missed something. Thanks!
