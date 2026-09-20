Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3963F58CC
	for <kvm@vger.kernel.org>; Sun, 20 Sep 2026 11:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789903371; cv=none; b=eAohvGKjb1oKQs6roVjnCXQYMtOSehaIUGlupbVDTf49G2blh/R8b3TTnik2V+550Q9/WSuCTNCBo2H1+CroxOq+7b4MmOjldwCkYArRhgt2IwAQBGB/4p9E2fX7AgYqLKKqsbj2CYTJohw77+UDV2cv0ePNnoFGoyYoCe2QdfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789903371; c=relaxed/simple;
	bh=TTSAmX1wYFJBw0fvvMopxHoUBy5D4DhhdG2PXyYgxwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ugBIUTFOC1D6yt0vu0FolCzImotIr0fSMJolqrorw46+Z/Nl2dUN/kJDW8gsy4/I2nY9GSBevvQuaBHxiq3oaUay9JPgs/h5LX7Z+uhh0+YoX+C2RXtVVUauTzZIGdUXh8mJji7+F7eQuBXUr2tNk2hSjhCZWJWBp6AUtzOOeRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=qyauvioD; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="qyauvioD"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BAE5F1650;
	Sun, 20 Sep 2026 04:22:40 -0700 (PDT)
Received: from [10.57.11.6] (unknown [10.57.11.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E7293F59E;
	Sun, 20 Sep 2026 04:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789903364; bh=TTSAmX1wYFJBw0fvvMopxHoUBy5D4DhhdG2PXyYgxwI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qyauvioDKvQzThtvSLBGUf00hBG20UnPEJ0clgBhfu9GvSX1Xg/pZH0QLdPzdQrkr
	 Rn/HeZaQOknJwH5vX2OkJANfmSbhrtNUJOSqrFM1awqd5vGcu96O0475S6SDtKKgrj
	 ScCxtmZV4s18MEl9M3NnkqviXS/2pMgmVqrptrYo=
Message-ID: <629e51dc-75ad-4727-b584-293a4081e7c9@arm.com>
Date: Sun, 20 Sep 2026 12:22:37 +0100
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Invitation] bi-weekly guest_memfd upstream call on 2026-09-17
To: Ackerley Tng <ackerleytng@google.com>,
 "David Hildenbrand (Arm)" <david@kernel.org>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, KVM <kvm@vger.kernel.org>
Cc: amit@infradead.org, aneeshkumar.kizhakeveetil@arm.com,
 ashish.kalra@amd.com, dwmw2@infradead.org, eberman@quicinc.com,
 fvdl@google.com, gshan@redhat.com, jackmanb@google.com, jackyli@google.com,
 jthoughton@google.com, kalyazin@amazon.com, kas@kernel.org,
 kevinloughlin@google.com, liruxin@google.com, michael.day@amd.com,
 michael.roth@amd.com, mike.rapoport@gmail.com, mvaralar@redhat.com,
 pankaj.gupta@amd.com, papaluri@amd.com, patrick.roy@linux.dev,
 Peter Xu <peterx@redhat.com>, pheragu@quicinc.com,
 pkondeti@qti.qualcomm.com, prty@google.com, psalian@google.com,
 qinkun@google.com, seanjc@google.com, shan.gavin@gmail.com,
 shivankg@amd.com, sidtelang@google.com, tabba@google.com,
 tatashin@google.com, vannapurve@google.com, vbabka@suse.com,
 wyihan@google.com
References: <b91dbfae-20f1-4b9f-a25b-4397afae80f9@kernel.org>
 <16ffff40-4ef0-4312-a700-348603f05c0c@kernel.org>
 <CAEvNRgGW_VHmT82q+bUqHh_5G2Z9sUF1jJOTiVN4Z8_cA9A50g@mail.gmail.com>
 <e4bcc676-34d3-45ed-9eda-51c9a60e977f@arm.com>
 <CAEvNRgFAL6qtSiJpQuga_TxWBr2pK=9LoiON+ZARMp0xFA8rPA@mail.gmail.com>
Content-Language: en-GB
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <CAEvNRgFAL6qtSiJpQuga_TxWBr2pK=9LoiON+ZARMp0xFA8rPA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ackerley,

On 18/09/2026 17:21, Ackerley Tng wrote:
> Suzuki K Poulose <suzuki.poulose@arm.com> writes:
> 
>>
>> [...snip...]
>>
>>>
>>> RMI_RTT_SET_RIPAS() is actually saying "host permits the conversion from
>>> base to top", it's not telling the RMM what to set it to, this is also
>>> different from SNP.
>>
>> As mentioned above, host knows the requested "RIPAS" from VCPU exit.
>> RMM knows the "RIPAS" from the VCPU object.
>>
>> Now: Privates vs Shared is translated to RIPAS_RAM vs RIPAS_EMPTY
>> in the CCA (well, roughly)
>>
>> RIPAS_RAM implies, the GPA can be mapped into the private address
>> space of the Realm and it is integrity protected. Host cannot
>> replace the GPA with another content (it can unmap and DESTROY
>> the GPA mapping. But unless the Realm consents to replace the
>> GPA, again via SET_RIPAS request).
>>
>>
>>>
>>> Interestingly RMI_RTT_SET_RIPAS() also errors out if the current
>>> shared/private state is different from the one tracked in the vCPU
>>> object in the RMM? Did I get that right? I'm looking at the base_align
>>
>> Correct.
>>
>>> Failure condition, where it says ripas_pre != rec.ripas_value.
>>
>> Please note that, in such cases, RMM needs a deeper page table level
>> and the error is RMI_ERROR_RTT, indicating to the host that:
>> Look I need a deeper level table to satisfy the request.
>>
>> e.g., base = 4K, but walk.level = 2, and ripas_pre="private"
>>
>> i.e. the requested base is mapped at L2 as block with "private" ripas.
>> If you want to convert the "base" to shared, it needs L3 table. The host
>> would follow up with RMI_RTT_CREATE and then retry the request.
>>
>>
>>> If two vCPUs race to convert the same range to shared, both vCPUs would
>>> have rec.ripas_value = private. The first conversion would be fine, but
>>
>> nit: rec.ripas_value = empty (shared)
>>
> 
> Sorry that was a bad mixture of pseudocode and constants on my part.
> 
>>> the second one woul see ripas_pre = shared but rec.ripas_value = private
>>> and would definitely get an error?
>>
>> rec.ripas_value == empty (shared) as per the guest request. And the RMM
>> will find the state is already "shared" and would confirm the success
>> back to host.
>>
> 
> Oh yes, my bad.
> 
> base_align says (rephrased)
> 
>    if (!AddrIsRttLevelAligned(base, walk.level) &&
>        ripas_pre != rec.ripas_value)
>            return RMI_ERROR_RTT
> 
> Is the alignment check to do with another vCPU splitting the record in
> the table?

Nope. The Host doesn't keep track of the levels at which the S2 mapping
is created nor does it track the "RIPAS" of the regions. That check is
making sure that we don't unnecessarily break down "block" mappings.

e.g., Before boot, the host might set RIPAS for certain regions (e.g.,
populated contents.) The Guest (firmware) could at boot then convert
all of the "DRAM" regions to RIPAS_RAM without checking what was
populated (this is anyway available in the Measurement). Thus a
conversion request may encounter regions that are already in the
requested state (RIPAS_RAM in the above case). And thus RMM
can report SUCCESS if it is already in the state.

Otherwise, we now need to split the block mapping to a deeper level
to apply the "state" change to a subset of the "block" range. This
is why we return RMI_ERROR_RTT when the requested RIPAS doesn't
match the "ripas_pre"

Does that help ? Remember that we don't have the concept of "ACCEPT"
in CCA.

Cheers
Suzuki


> 
> Why compare ripas_pre and rec.ripas_value when the level is not aligned?
> 
>>
>>>
>>> And there's no "accept" step in the guest after conversions, which makes
>>> it different from TDX and SNP.
>>
>> Correct, the guest "permitted" the GPA to be made private with unknown
>> contents anyway. RMM guarantees that the "data" is scrubbed when the
>> GPA is made valid. The advantage with this approach is, once the
>> Guest sets the RIPAS_RAM, the host can lazily donate pages at
>> fault time
>>
>>>
>>> Difficulty in using current gmem hooks that SNP uses:
>>>
>>> * .gmem_make_shared() called from conversions doesn't have the vCPU
>>>     context, finding the right vCPU context is expensive.
>>>       * Sean, don't we already iterate vCPUs to find VMSA pages to kick
>>>         the right vCPUs?
>>
>> We could keep a list of VCPUs with pending set-ripas request for e.g.
>> Or before the vCPU enter, we check the state of the region and
>> do the sync with RMM.
>>
>>> * .gmem_make_private at fault time is too late
>>>       * At the next vCPU enter, the RMM would already read it's state to
>>>         report success/failure, and there's no fault in-between for the
>>>         .gmem_make_private to happen.
>>>
>>> At the call Sean suggested mirroring the RMM's tracking in KVM, but that
>>> sounds quite arch-specific and it's like doing arch-specific validation
>>> within KVM.
>>
>> Suzuki
>>
>>
>>>
>>> p.s. Fuad, for pKVM you also mentioned that you'll need to check if the
>>> guest had requested for conversion first? This might be the same/similar
>>> problem.

