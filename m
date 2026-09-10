Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34A63B14B6;
	Thu, 10 Sep 2026 10:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789034634; cv=none; b=YI9zCO20JhIgXqtVDw16guS1qHLSrxgns2khmHpk8NfoxbAEoDkGi+1wzsZ1QK73UcteDTOQq5+hzDNdYTJr9Bvw+vS8RECC7vKaT2BHZjocpa8Xge18mawSO2ZLAG7KXJAhzAC1fA1lt9j/5s//9F/zgF6lN0UB3rEcakJ26b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789034634; c=relaxed/simple;
	bh=hlvb4WNjzMB0gRvMldagX4Uhid9PpyKhPjjmMAyVjvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sBEEdlqWvCZIvsTAg+6QatyHSB1mv5eSSbsBJ7yyLCKVBsMo8IBz5bnqusL/IgECTsYcV2kxfqqgkcnniu6g06+KnTBI7EBcB9SZCA1tTw+k6FiUoZ0Hb8i4bOs09zGS/P4LKILg3zksQrLQDcNYeaP5EWl5Cu4Q93ldpXUpjVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KSilTxny; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KSilTxny"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 107771F000FF;
	Thu, 10 Sep 2026 10:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789034622;
	bh=d6X874Xrr4USoK1MTGkxBCcI6O6k/kEejm0Rs8M2xgI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=KSilTxnykwDLR+U3kjOVLr+CmFJNrFBj+ywnUwLG4EDY6T7i9rZ0/XFHJRAUxB8Cg
	 uqldP1L+oOYwVYS+nTPu9ABsJ/c4y13h6g8tMTZP05a5LhHIQGcJgTz7N4er5qin/P
	 TdDYrSZqPhFpvfWNrCv2w8cKPMKZ2pjwRnlmep6cVJr8RB8MUjJ8ZYY7H4eN8GF7tm
	 z1qahItZ9O9f5fZTHZnfmxkt4xxnbxtyNAUDI3cGONITin5oQR90wv7UX+e7Nn0Tcf
	 +q+DIRfuBfX1UoO8t5Ai2ZyWKSJvKhnAtfQjvp3VJ7tFGlZDMAkXCkaCAaLqSainrz
	 cD2P0SJBso/cg==
Message-ID: <8fa1b403-99b0-4508-b705-f9e93c6bf0c8@kernel.org>
Date: Thu, 10 Sep 2026 12:03:28 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/9] mm: split AS_UNMOVABLE back out of AS_INACCESSIBLE
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
 Nikunj A Dadhania <nikunj@amd.com>, Michael Roth <michael.roth@amd.com>,
 Pankaj Gupta <pankaj.gupta@amd.com>, Ackerley Tng <ackerleytng@google.com>,
 Sean Christopherson <seanjc@google.com>,
 Vishal Annapurve <vannapurve@google.com>,
 Nikita Kalyazin <nikita.kalyazin@linux.dev>,
 Patrick Roy <patrick.roy@linux.dev>, Pratik Sampat <prsampat@amd.com>,
 Ashish Kalra <Ashish.Kalra@amd.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Peter Shier <pshier@google.com>,
 Jim Mattson <jmattson@google.com>, Ricardo Koller <ricarkol@google.com>,
 Ira Weiny <iweiny@kernel.org>, Fuad Tabba <fuad.tabba@linux.dev>
Cc: linux-fsdevel@vger.kernel.org, linux-coco@lists.linux.dev,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
References: <20260805-shivank-gmem-migrate-v3-0-00d8bdec4e1d@amd.com>
 <20260805-shivank-gmem-migrate-v3-2-00d8bdec4e1d@amd.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260805-shivank-gmem-migrate-v3-2-00d8bdec4e1d@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/5/26 08:40, Shivank Garg wrote:
> Commit 27e6a24a4cf3 ("mm, virt: merge AS_UNMOVABLE and AS_INACCESSIBLE")
> folded the two flags into one, on the grounds that guest_memfd was the
> only user and always set both. But the two flags were added for
> different reasons and guard different things:
> 
>   AS_UNMOVABLE (0003e2a41468) marks a mapping whose folios cannot be
>   migrated.
> 
>   AS_INACCESSIBLE (c72ceafbd12c) marks a mapping whose contents must
>   not be directly R/W accessed. Its only job is to stop
>   truncate_inode_partial_folio() from zeroing the folio.
> 
> The merge assumed unmovable and inaccessible were the same thing.
> This cannot express a mapping that is inaccessible yet still movable,
> which is exactly what guest_memfd wants.
> 
> Reintroduce AS_UNMOVABLE and restore the original split: truncate keeps
> checking AS_INACCESSIBLE, while migration and compaction go back to
> checking AS_UNMOVABLE.
> 
> Currently guest_memfd sets both, so the resulting flags and behaviour
> are unchanged. Preparatory change to support folio migration for
> non-confidential guest_memfd VMs.
> 
> Signed-off-by: Shivank Garg <shivankg@amd.com>
> ---
>  include/linux/pagemap.h | 24 ++++++++++++++++++++----
>  mm/compaction.c         | 12 ++++++------
>  mm/migrate.c            |  2 +-
>  virt/kvm/guest_memfd.c  |  1 +
>  4 files changed, 28 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 2c3718d592d6..a7dcaa66e4e3 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -210,6 +210,7 @@ enum mapping_flags {
>  	AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM = 9,
>  	AS_KERNEL_FILE = 10,	/* mapping for a fake kernel file that shouldn't
>  				   account usage to user cgroups */
> +	AS_UNMOVABLE = 11,	/* The mapping cannot be moved, ever */
>  	/* Bits 16-25 are used for FOLIO_ORDER */
>  	AS_FOLIO_ORDER_BITS = 5,
>  	AS_FOLIO_ORDER_MIN = 16,
> @@ -322,11 +323,10 @@ static inline void mapping_clear_stable_writes(struct address_space *mapping)
>  static inline void mapping_set_inaccessible(struct address_space *mapping)
>  {
>  	/*
> -	 * It's expected inaccessible mappings are also unevictable. Compaction
> -	 * migrate scanner (isolate_migratepages_block()) relies on this to
> -	 * reduce page locking.
> +	 * The mapping's contents must not be accessed by the CPU through
> +	 * the kernel direct map or other internal paths (e.g. zeroing of
> +	 * pages during truncation).
>  	 */
> -	set_bit(AS_UNEVICTABLE, &mapping->flags);
>  	set_bit(AS_INACCESSIBLE, &mapping->flags);
>  }
>  
> @@ -335,6 +335,22 @@ static inline bool mapping_inaccessible(const struct address_space *mapping)
>  	return test_bit(AS_INACCESSIBLE, &mapping->flags);
>  }
>  
> +static inline void mapping_set_unmovable(struct address_space *mapping)
> +{
> +	/*
> +	 * It's expected unmovable mappings are also unevictable. Compaction
> +	 * migrate scanner (isolate_migratepages_block()) relies on this to
> +	 * reduce page locking.
> +	 */
> +	set_bit(AS_UNEVICTABLE, &mapping->flags);
> +	set_bit(AS_UNMOVABLE, &mapping->flags);
> +}
> +
> +static inline bool mapping_unmovable(const struct address_space *mapping)
> +{
> +	return test_bit(AS_UNMOVABLE, &mapping->flags);
> +}
> +
>  static inline void mapping_set_writeback_may_deadlock_on_reclaim(struct address_space *mapping)
>  {
>  	set_bit(AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM, &mapping->flags);
> diff --git a/mm/compaction.c b/mm/compaction.c
> index f08765ade014..e6b0fdfaf79d 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1133,22 +1133,22 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>  		if (((mode & ISOLATE_ASYNC_MIGRATE) && is_dirty) ||
>  		    (mapping && is_unevictable)) {
>  			bool migrate_dirty = true;
> -			bool is_inaccessible;
> +			bool is_unmovable;
>  
>  			/*
>  			 * Only folios without mappings or that have
>  			 * a ->migrate_folio callback are possible to migrate
>  			 * without blocking.
>  			 *
> -			 * Folios from inaccessible mappings are not migratable.
> +			 * Folios from unmovable mappings are not migratable.
>  			 *
>  			 * However, we can be racing with truncation, which can
>  			 * free the mapping that we need to check. Truncation
>  			 * holds the folio lock until after the folio is removed
>  			 * from the page so holding it ourselves is sufficient.
>  			 *
> -			 * To avoid locking the folio just to check inaccessible,
> -			 * assume every inaccessible folio is also unevictable,
> +			 * To avoid locking the folio just to check unmovable,
> +			 * assume every unmovable folio is also unevictable,
>  			 * which is a cheaper test.  If our assumption goes
>  			 * wrong, it's not a correctness bug, just potentially
>  			 * wasted cycles.
> @@ -1161,9 +1161,9 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>  				migrate_dirty = !mapping ||
>  						mapping->a_ops->migrate_folio;
>  			}
> -			is_inaccessible = mapping && mapping_inaccessible(mapping);
> +			is_unmovable = mapping && mapping_unmovable(mapping);
>  			folio_unlock(folio);
> -			if (!migrate_dirty || is_inaccessible)
> +			if (!migrate_dirty || is_unmovable)
>  				goto isolate_fail_put;
>  		}
>  
> diff --git a/mm/migrate.c b/mm/migrate.c
> index dd15a84b2a52..d4dcd7f142ce 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1101,7 +1101,7 @@ static int move_to_new_folio(struct folio *dst, struct folio *src,
>  
>  	if (!mapping)
>  		rc = migrate_folio(mapping, dst, src, mode);
> -	else if (mapping_inaccessible(mapping))
> +	else if (mapping_unmovable(mapping))
>  		rc = -EOPNOTSUPP;
>  	else if (mapping->a_ops->migrate_folio)
>  		/*
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 45cbdf4801ec..169f75f95433 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -593,6 +593,7 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
>  	inode->i_size = size;
>  	mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);
>  	mapping_set_inaccessible(inode->i_mapping);
> +	mapping_set_unmovable(inode->i_mapping);

For shared-only guest_memfd, is there even a reason to mark it as
mapping_set_inaccessible() ?

mapping_inaccessible() is only used in truncation and compaction logic.

Wouldn't we want compaction to work here?

IOW, for shared-only with migration support, can't we just not do
mapping_set_inaccessible() ?

-- 
Cheers,

David
