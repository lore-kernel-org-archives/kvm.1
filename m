Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27021271468;
	Tue, 10 Mar 2026 10:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773139374; cv=none; b=od2gSCy4cnd8Ga/4dU5q2FIJQtyBbLCvW7yv69nhmq3UzzCo4JOimYyvZtGm+s93MmhEVbr3eNGlfA/OXM/0xlBOrWjfEobB1y6MOY+R4ysa4bRfZWTaXH7a/2lF1RqZ7N8W+DIpn4TPf2sso8Ecjg4Uxi10nLR2iNohAV0rUQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773139374; c=relaxed/simple;
	bh=3m4rwlvUFZd/0jBCZKj1ip7fgfW/CYTB+r1GS0xW8Zg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=IaKAjVrcIfZ6rSqW62BUD8ISAFpkVaA61SR6oJFtg1zRagaXEsuhcezSvvC/1K9SHaogoNprBm+EP1jRz2IzzUXIsSGWIDf1c7wBE0NKvnvv8kzwga8V+tIOX5YHLNgk7Jf9ABmgmMavKumj3ds/DdmARbQThazJkPXm9yPc12U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oMYZgNyO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oMYZgNyO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBAC8C19423;
	Tue, 10 Mar 2026 10:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773139373;
	bh=3m4rwlvUFZd/0jBCZKj1ip7fgfW/CYTB+r1GS0xW8Zg=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=oMYZgNyO6Nw0x10/mkbxLbNa3w2PDuEiOMmiGOmxmWdsAOPsFzktLpRkbixkawRet
	 tj5YdvGt4sREgy8o/poBYWzHo4fTpp++pr5X2UMGlzKyJcO8Kg96Ns1yjhKZcd7txE
	 5EvJ6fTGwznHjJt6UprwMhfYioMNPBGVGqIg552QXnbdj/17cl6RZWlu6qMSpQI5f3
	 fLdCzn89uMtWTne6Wzrz92K8HderdBAcLDYXaxhjU2rrPCC8xYXawirkfsEz2sAUxV
	 Bw96P6McCBiZSVtvb2iwX4n2pJqHd42GbNC+AhmVlZYV+E4WHOf2LHjNboUFKYdqJn
	 gzzi3dYFxAlaA==
Message-ID: <d987d8a2-07b5-477c-9ca1-23eb7947768d@kernel.org>
Date: Tue, 10 Mar 2026 11:42:47 +0100
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Vlastimil Babka <vbabka@kernel.org>
Subject: Re: [PATCH v1 0/4] mm: move vma_(kernel|mmu)_pagesize() out of
 hugetlb.c
Content-Language: en-US
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Cc: Pedro Falcato <pfalcato@suse.de>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Dan Williams <dan.j.williams@intel.com>
References: <20260306101600.57355-1-david@kernel.org>
 <4rzf46kw6hq3b5ivv7cvgyza4yfrvk2shrncytobabxef644nm@wzu2bw63co37>
 <371cf0f7-4b30-4d8c-99e7-ae0543f8be23@lucifer.local>
 <5eae6c52-c3f9-407e-8fb8-01a950b282bf@kernel.org>
 <9172a09f-f014-4a76-b813-8f0c79fbe2f4@lucifer.local>
 <19fdac31-0d2e-4662-b3a4-02555d8e4221@kernel.org>
In-Reply-To: <19fdac31-0d2e-4662-b3a4-02555d8e4221@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/9/26 16:07, David Hildenbrand (Arm) wrote:
> On 3/9/26 14:42, Lorenzo Stoakes (Oracle) wrote:
>> On Fri, Mar 06, 2026 at 02:12:50PM +0100, David Hildenbrand (Arm) wrote:
>>> On 3/6/26 12:19, Lorenzo Stoakes (Oracle) wrote:
>>>>
>>>> Yeah I noticed this also :>) Assumed it was a new way of doing things somehow?
>>>> :P
>>>
>>> "--cc-cover" is apparently not the git default on my new machine.
>>>
>>> "See, I CCed you, I totally did not try to sneak something in. Oh, I
>>> messed up my tooling, stupid me ...". :)
>> 
>> ;)
>> 
>> Wasn't aware of that option actually, handy!
> 
> On my old setup I had a script that would, in addition, also CC anybody
> CC'ed on individual patches on the cover letter. Was quite useful for
> larger series where you don't want to spam people with unrelated patches.

I had such a script too.

> Still have to set that back up.

But now "b4 send" does that for me automatically. And I don't need to do a
"git format-patch" beforehand. It also does the equivalent of "--cc-cover".
