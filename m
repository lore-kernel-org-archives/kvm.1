Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793833544;
	b=KqiwZyDHqahGR0yL70w2KGcoS24zxrBqbltxIYa3zXpieS2GMX8a+/iqAWnbAr59FnlT
	 jXFQB09ys7cBijTsxQKpa75UrBsmQ9cM9F9wPFycCHTNvJEBKZIS9JMcqojL1hk6wsu2W
	 sTGPy5EInA26kYT1DWpl5AVKRhR/HoSFRsMaGDuhglR5dsSkCZCh9TerGuFOwglDXPxM+
	 EYmTS5+nvxDrXHzd5QCQzNG80mBXYJh2n89Gi6ZdfMsPL4AIqTv8Gl7MMvLkY8tQGMHG6
	 VKh94T8VUiQdjHKbhTaorLoW5uiyt7Te1MVDilr+O9u9mhlTAxC0tlmC4ZRITThehfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793833544;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=MOpStKtlaMBvTw82l7hk12nLoKUsFYT90GYDj+kAndo=;
	b=vZmoQzucAazmdDUhWJ86oy4WdRGyFRtNEGd8Qng1jFEo3ayL6nqZxCuHtJuMjchSVNs9
	 5y2nhCbmjddkO5BPD+U+6eWmn+kKdsJR9MZ/g/35RwMIiGwT2r3rG8mmZxwFyFa/sZDre
	 N6EdWoNQE5iYfsD/k4YvZOtFgSIKRQICNpeI3ciy6UGYknDo3ZZGEqk56I3S/Ut0n2/3K
	 2cXL+SJqrc0IEK+dBKqux+CrD0GmGt/csv9+6/8bSwYpkZovBxDa/Qvtveh76MA4K0c7V
	 OPsx6J6bOd9F7M7zZaW9dW8HmkCp/l7gExH9ExFDyxZPCDsb54lJr08dLxVbihMfizg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sCwcKa7X;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A11F606A32E
	for <kvm@vger.kernel.org>; Wed,  4 Nov 2026 23:05:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A11F606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sCwcKa7X
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a4d7ae1ae9so12635465e9.1
        for <kvm@vger.kernel.org>; Wed, 04 Nov 2026 15:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793833542; x=1794438342; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MOpStKtlaMBvTw82l7hk12nLoKUsFYT90GYDj+kAndo=;
        b=sCwcKa7XbJktqL3hxABBeqm06+tWavHjtuY13tBflSMCRtQb+wZIupMviVt6gaX6aY
         Gb9TJwBPCahNivxGH/4ZBVweXRACmfAUBmS5eRN1ZkDU69Anp6MagJP+cxNGL7+tJgXz
         p+Kcz18jfYceosvOUAwRmqY2+5tFQcQ5tQ2GQkpZ9xudcmbmi/Qn0s1Cd1Xza7qUK+NZ
         /vH11hu6YvBS6n6hCopNr6WXk9fwzMrVX5v74pOHwKCe8+0dkjS1vNPQjdXhvQTlu3Ac
         HJI8b6gp5lEsT/akwfpznC57AQHWn+lgT1UC70Yr97MslML0Ty938MRMwLso/ME8upGI
         bZ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793833542; x=1794438342;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MOpStKtlaMBvTw82l7hk12nLoKUsFYT90GYDj+kAndo=;
        b=Mu9C84wUsJqeRtDhqu6Rro0SBN1c9spnl7T7LLa2ZdlEP5aTwHsTICqE3iAzPkuv9h
         4tjoXT63SHqJGh4aTSKlSkfINMaR0qcS/7vpeDxtWebqb0dFlDCRHCgqYfHbYURjYd0W
         3luSlCSNiM9VXfc11P7m/wCRrWIsemTDdneCseKJatiT/dvhCWYbcFPV3ZN9PnkV6Jn5
         zIVwJxSk4Og3gFBJUbiKNYdHDMnhv3f8FYxG+zbKc+BeTPoAr8Lx1mycbtz4tR0Q4Cy0
         vHqu99zyZ8kBnU0HpPosMnPlkx0ghH2q72SBnQ6NTtjeZwsxXTdYRJ0cA17TR9w21vn3
         s83Q==
X-Forwarded-Encrypted: i=1; AKwUvBx0a/rnDeuh/X5LuoCf0jXv5WDXyaulwrsO/g2HOCZdVA4flAOBCZkamBTJ0Q6RUbGbHaw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Exqbk1w4DXsNGXDAc+kA3n3NnbwwwWUd24f7Vy2LaKbW54PTS
	unyJca+LNj0+zCml80sB3ulICWawk9wvPpGbZ3HBMdt9GmoCJETohsTX
X-Gm-Gg: AYBFou3z9v6Eofnh6bXnUGH6UmxZE7SelsTcMkbrifxqCSA7dl2IiAXoKeHHULJlPTc
	jSGwnYBPH9ig4dA4yxViBKwLXmVXS3aTdPvR3ckR7iZiuiBsr8Be0q9mF5SWcI/KXxRaQsWeeyU
	4btH5PsmZDnMiBZ0wsghD2Nfpam7PcB9COk+V+5y58ao9qn+/8T10Ijc3wtRYUTgLkyKrz0GLzx
	XKhre4B61tkBgw1Em+kIctqztf2vL4RP2JJgik0ciqXgFsQPFeO/d0hUrd1+x7+5dO3j7JjYT3y
	Xr0USrHP9AVNpLV7HudyKvIK+JUAjAaftNoNxkVrF7TyUoVqCMa9/TmavY0NEcq4CTqFLp5YMPZ
	qoAbXF9G7I3gPLL8Hce7zI9bNoGirMYfHpjyOgX3m6L349wl+h+Fmieyf1sJdGtlOPceM+Ft2Un
	1oK44284QTdWNnfZJga+I+SXYbXOFxJBA1pHDEwp9R9T92odgub8FEQZOaAqjPF0467d2AnR0P5
	Vxm1G45Nn3RY31QZIrhgbgurHm6cSmADIAM3yNmo0PPEGWAucktrAD/vZfoNMSZFnxiGWmdTn6Z
	Dt9U8SMvO4sx1eKvTJIb/UA=
X-Received: by 2002:a05:600c:19d1:b0:4a2:677:ad8e with SMTP id 5b1f17b1804b1-4ac1970b9f7mr379985715e9.34.1793833541916;
        Wed, 04 Nov 2026 15:05:41 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fed5538basm5998977f8f.44.2026.11.04.15.05.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 15:05:40 -0800 (PST)
Message-ID: <853a133d-f332-47dc-b7f3-eb57f34d9344@gmail.com>
Date: Thu, 5 Nov 2026 00:05:38 +0100
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/4] mm/huge_memory: copy file THPs at fork like
 copy_present_ptes() does
To: Konstantin Khorenko <khorenko@virtuozzo.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "David Hildenbrand (Arm)" <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
 Peter Xu <peterx@redhat.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org,
 =?UTF-8?Q?Lo=C3=AFc_Molinari?= <loic.molinari@collabora.com>,
 Lorenzo Stoakes <ljs@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
 stable@vger.kernel.org
References: <20261104-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v5-0-c56d0d26f970@virtuozzo.com>
 <20261104-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v5-2-c56d0d26f970@virtuozzo.com>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <20261104-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v5-2-c56d0d26f970@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/26 9:40 PM, Konstantin Khorenko wrote:
> This fixes no bug: it makes fork copy a PMD the way copy_present_ptes()
> copies a PTE. Until now copy_huge_pmd() skipped every folio PMD of a
> non-anonymous VMA and left the child to fault them in again, while the
> PTEs of the same VMA are copied.
> 
> Treat file folios as the PTE path does: take a reference, duplicate the
> rmap and account them. fork then pays a reference and an rmap update
> per PMD, and saves the child a fault per PMD it touches. The next patch
> sends PFN mappings through the same tail.
> 
> That covers the VMAs vma_needs_copy() sends here:
> 
> - private file mappings with an anon_vma;
> - VM_COPY_ON_FORK ones: uffd-wp and uffd-rwp, VM_MIXEDMAP, and
>   VM_MAYBE_GUARD, which shared shmem, file and DAX mappings get from a
>   guard region.
> 
> The DAX huge zero PMD is copied too, with a reference taken by
> mm_get_huge_zero_folio() as for anonymous VMAs. A migration entry of a
> file folio is copied and accounted like copy_nonpresent_pte() does, and
> made read-only in both processes only in a CoW mapping. A device
> private entry gets the same CoW check, as in copy_nonpresent_pte().
> 
> The copy then gets the same tail as __copy_present_ptes(): write
> protect both sides in a CoW mapping, mark the child's copy clean in a
> shared one, and drop the uffd-wp bit where the child is not armed. An
> anonymous THP is now write protected only when its PMD is writable, as
> a PTE is.
> 
> A page table is deposited under the copy where the fault paths deposit
> one: in anonymous VMAs, and wherever the architecture needs one.
> 
> Cc: stable@vger.kernel.org # needed by the next patch
> Suggested-by: David Hildenbrand (Arm) <david@kernel.org>
> Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>

LGTM:

Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

-- 
cheers,
jose a. p-a
