Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B0037997E;
	Mon, 15 Jun 2026 18:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781548533; cv=none; b=WPa6+QlaqzxEJAyYUUc1jBHzpQCKgdoaub40vArj4gHN3t8XUPkJLaL3anlyQptgGK+KAP0xC7k4BGzwv97f5oMcQLWAPMvpO8vNveL1sG6skB7w1djDhStZ66ym/dcVumIP4bKOO1k1xYwbyY1Jd9JzAWOuxArMVJ2e3BVr5+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781548533; c=relaxed/simple;
	bh=2h3R1KaG6R0309+dcpm2CGuj1MxQ+ME+WvA5c8KJVg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dWn3srSRNCZ2zMlPS8EKYpr1zGbE26Iyh5zoT9WkAT8b0ppY33fIyFlJt9gfnruwgmF9EXFaDI0xlJ/jh7tbSjT4S90l4XB6DcIHi90PkZtEXD2VFRJ6fmud69p0AVjRZ4c1LhtF34S855+oiSH7KsUkjFMusBf/exO9hN+9dKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jlAQG2xW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jlAQG2xW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0454D1F000E9;
	Mon, 15 Jun 2026 18:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781548532;
	bh=hzUbXfgg1+bBubgu8gN+hwknySP5HOytcelW2HhsCuA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=jlAQG2xWMZDdf/TzVptw6qaxuKXJK92zOL3nTKtS7cwaic2k+bAq+ARNG9AezSHH8
	 IS2fSOS9S07JnquBqBhgmdo1FGtmTkV03sgRuB22ATBYrEUyqqpgrtp0fJtk8HPhKm
	 ulaxvPNAnX2dXPwAwr5kpilaGWvIcjWK0OHquB/CUSlk0p48wTWjRmQ+86zfYQDoCm
	 Xluit6eChkKE3LPRx7VyEw/d81L+RRLbRF9jTEfjOBTKi6jkh0TPFTM7b5CFMX1Z13
	 DDysW8JKdDtafNe5Ay8+LAeF94jqSNCVoSw63n3Wa7CQBIuWYFQ5vYM4PEvYd4rw1J
	 FPUWgIJy6t6mA==
Message-ID: <1f74f3b9-fda5-40e1-9170-5861ebac9ca8@kernel.org>
Date: Mon, 15 Jun 2026 20:35:21 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/3] KVM: guest_memfd: support folio migration for
 non-confidential VMs
To: Shivank Garg <shivankg@amd.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Shuah Khan <shuah@kernel.org>, Chao Peng <chao.p.peng@linux.intel.com>,
 Nikunj A Dadhania <nikunj@amd.com>, Ira Weiny <ira.weiny@intel.com>,
 Michael Roth <michael.roth@amd.com>, Pankaj Gupta <pankaj.gupta@amd.com>,
 Ackerley Tng <ackerleytng@google.com>, Fuad Tabba <tabba@google.com>,
 Sean Christopherson <seanjc@google.com>,
 Vishal Annapurve <vannapurve@google.com>,
 Nikita Kalyazin <nikita.kalyazin@linux.dev>,
 Patrick Roy <patrick.roy@linux.dev>, Pratik Sampat <prsampat@amd.com>,
 Ashish Kalra <Ashish.Kalra@amd.com>
Cc: linux-fsdevel@vger.kernel.org, linux-coco@lists.linux.dev,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260611-shivank-gmem-migrate-v1-0-2d266bfc6f95@amd.com>
 <20260611-shivank-gmem-migrate-v1-2-2d266bfc6f95@amd.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260611-shivank-gmem-migrate-v1-2-2d266bfc6f95@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/11/26 15:05, Shivank Garg wrote:
> guest_memfd folios are currently marked unmmovable, so the kernel
> cannot perform NUMA-balancing, memory compaction, etc.
> This is unavoidable for confidential VMs (SEV-SNP, TDX),
> since memory is encrypted and copying it need firmware assistance.
> However, for non-cofidential VMs (like firecracker), we can migrate
> the folios.
> 
> Mark non-confidential VMs as movable and implement
> kvm_gmem_migrate_folio() using filemap_migrate_folio().
> 
> This lays the ground work for migrating cofidential guest_memfd
> later. Once the firmware-assisted copying support is available,
> those VMs can be made movable. The confidential folio content can
> be copied separately, and the destination folio can be marked with
> FOLIO_CONTENT_COPIED so __migrate_folio() skips the host-side
> folio_mc_copy().
> 
> Signed-off-by: Shivank Garg <shivankg@amd.com>
> ---
>  virt/kvm/guest_memfd.c | 50 +++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 45 insertions(+), 5 deletions(-)
> 
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 806a42f0e031a1c7729f53c786316d2502532553..e4470106fc7792f328bce5275419683328c8b4ab 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -487,13 +487,45 @@ static struct file_operations kvm_gmem_fops = {
>  	.fallocate	= kvm_gmem_fallocate,
>  };
>  
> +#ifdef CONFIG_MIGRATION
>  static int kvm_gmem_migrate_folio(struct address_space *mapping,
>  				  struct folio *dst, struct folio *src,
>  				  enum migrate_mode mode)
>  {
> -	WARN_ON_ONCE(1);
> -	return -EINVAL;
> +	struct inode *inode = mapping->host;
> +	pgoff_t start, end;
> +	int ret;
> +
> +	if (!filemap_invalidate_trylock_shared(mapping))
> +		return -EAGAIN;
> +
> +	start = src->index;
> +	end = start + folio_nr_pages(src);
> +
> +	kvm_gmem_invalidate_begin(inode, start, end);
> +
> +	/*
> +	 * For non-confidential guest_memfd the folio is host-readable,
> +	 * so filemap_migrate_folio() can copy the contents itself via
> +	 * folio_mc_copy().
> +	 *
> +	 * This is also the hook point for confidential VMs (SEV-SNP, TDX) once
> +	 * they are made movable: the host cannot copy encrypted/private memory,
> +	 * so a firmware-assisted copy would run here.
> +	 * Idea: https://lore.kernel.org/r/20260428155043.39251-8-shivankg@amd.com
> +	 * Mark the @dst->migrate_info field with FOLIO_CONTENT_COPIED, so
> +	 * __migrate_folio() skip folio_mc_copy() for confidential VMs.
> +	 */
> +	ret = filemap_migrate_folio(mapping, dst, src, mode);
> +
> +	kvm_gmem_invalidate_end(inode, start, end);
> +
> +	filemap_invalidate_unlock_shared(mapping);
> +	return ret;
>  }
> +#else
> +#define kvm_gmem_migrate_folio NULL
> +#endif
>  
>  static int kvm_gmem_error_folio(struct address_space *mapping, struct folio *folio)
>  {
> @@ -592,9 +624,17 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
>  	inode->i_size = size;
>  	mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);
>  	mapping_set_inaccessible(inode->i_mapping);
> -	mapping_set_unmovable(inode->i_mapping);
> -	/* Unmovable mappings are supposed to be marked unevictable as well. */
> -	WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));
> +
> +	/*
> +	 * Confidential VMs (SEV-SNP, TDX) bind encryption to the physical
> +	 * address and require firmware assisted copy, so their folios cannot
> +	 * be migrated yet.
> +	 */
> +	if (kvm_arch_has_private_mem(kvm)) {
> +		mapping_set_unmovable(inode->i_mapping);
> +		/* Unmovable mappings are supposed to be marked unevictable as well. */
> +		WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));

We would still want our movable mappings to be flagged unevictable.

> +	}
>

As discussed, for guest_memfd instances that support page migration, we would
want to also allocate the pages in for guest_memfd as GFP_HIGHUSER_MOVABLE.

That is, handle the mapping_set_gfp_mask() call as well.

It will unlock access to areas reserved for movable allocations (CMA/
ZONE_MOVABLE) and properly let the page allocator group pages by mobility
(MOVABLE vs. UNMOVABLE vs. RECLAIMABLE).

-- 
Cheers,

David
