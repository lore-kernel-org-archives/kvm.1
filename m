Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B0B184524;
	Mon, 15 Jun 2026 11:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781521469; cv=none; b=SpzBLKOFFL8HVS7cPus7dojM14quOaZbziBIp/o/bWuYtqey1ry7O9WLAQBxyDBYeVDpAm+XlNbuOvMN/DRqHZRljQfgKtOJaUf3cd/OnFE8p2UC7mPouIKe18JkRDXm6NtyAwu2ApivTX2k9tVA9TMcAYCMsS23VvmlAp0mi84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781521469; c=relaxed/simple;
	bh=G5bCUMpAj7XkCblIAeX+67lQJO0pVJ0HsMawKtJgxQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZSx/smY0+Y1tyYeWXFoGI5XRlHEgoh6+nZIx8Qa4N2XUENBBuzhsibUidKLSlLw1xioMe8dMibI6I9dM3XFU+MJZPDeFyqxcUJNjF2/Pti8s1Oh3cvbFFwfxhvXP9zitqM2/xt0Dul/rf8Fm4OWn/KgnXGFNCJp3mqwFRzwH4Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ITcrxen1; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ITcrxen1"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4303E328D;
	Mon, 15 Jun 2026 04:04:22 -0700 (PDT)
Received: from raptor (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E54C13F915;
	Mon, 15 Jun 2026 04:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781521467; bh=G5bCUMpAj7XkCblIAeX+67lQJO0pVJ0HsMawKtJgxQU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ITcrxen1FUILXt0yTvFGlM97RCokdSUG6KreIW5VnfKj1yUsv5nAXAUCQjVOZEyus
	 1bxtVRPtXhyGGGbSLmKSdOfzkBrck+oXlbdN9jdKXe1uibx4w6l3zzqX0H/xXyhSXE
	 z3BP5/FQv9K7Ctbm7B/qLe39ZaH6N64JsRAQb/a8=
Date: Mon, 15 Jun 2026 12:04:15 +0100
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: Shivank Garg <shivankg@amd.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	David Hildenbrand <david@kernel.org>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Chao Peng <chao.p.peng@linux.intel.com>,
	Nikunj A Dadhania <nikunj@amd.com>, Ira Weiny <ira.weiny@intel.com>,
	Michael Roth <michael.roth@amd.com>,
	Pankaj Gupta <pankaj.gupta@amd.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Fuad Tabba <tabba@google.com>,
	Sean Christopherson <seanjc@google.com>,
	Vishal Annapurve <vannapurve@google.com>,
	Nikita Kalyazin <nikita.kalyazin@linux.dev>,
	Patrick Roy <patrick.roy@linux.dev>,
	Pratik Sampat <prsampat@amd.com>,
	Ashish Kalra <Ashish.Kalra@amd.com>, linux-fsdevel@vger.kernel.org,
	linux-coco@lists.linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC 0/3] KVM: guest_memfd: folio migration for
 non-confidential VMs
Message-ID: <ai_aczmeH2IA6JaB@raptor>
References: <20260611-shivank-gmem-migrate-v1-0-2d266bfc6f95@amd.com>
 <ai_XK__RTXMCEcCG@raptor>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ai_XK__RTXMCEcCG@raptor>

Hi,

On Mon, Jun 15, 2026 at 11:43:14AM +0100, Alexandru Elisei wrote:
> Hi,
> 
> On Thu, Jun 11, 2026 at 01:05:07PM +0000, Shivank Garg wrote:
> > guest_memfd folios are currently marked unmovable, so the kernel cannot
> > perform NUMA-balancing, memory compaction, etc. This is unavoidable for
> > confidential VMs (SEV-SNP, TDX), since memory is encrypted and copying it
> > needs firmware assistance. However, for non-confidential VMs (like
> > Firecracker), we can migrate the folios.
> > 
> > This series enables folio migration for non-confidential guest_memfd and
> > also lays the groundwork for migrating confidential guest_memfd later.
> > Once firmware-assisted copying support is available, those VMs can be
> > made movable, the confidential folio content can be copied separately,
> > and the destination folio marked with FOLIO_CONTENT_COPIED so
> > __migrate_folio() skips the host-side folio_mc_copy().
> 
> I always thought that one of the nice things about using guest_memfd as a
> memory backend, as opposed to host userspace mappings, is that the host
> cannot unmap VM memory because of KSM, automatic NUMA balancing, hugepage
> collapse, compaction, etc, acting on the host userspace mapping of the
> VM memory, and outside of the VMM's or KVM's control.
> 
> I think it would be useful to preserve this behaviour, even in the absence
> of confidential VMs (i.e, guest_memfd file descriptor created with
> GUEST_MEMFD_FLAG_MMAP).

Just to be clear, I was thinking that it might be useful for both
behaviours to exist (migratable and non-migratable) for non-confidential
VMs, and allow KVM or userspace to decide which they prefer for a
guest_memfd.

Thanks,
Alex
