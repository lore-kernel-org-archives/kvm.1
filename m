Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAEE3D8110;
	Wed, 11 Mar 2026 11:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773230390; cv=none; b=oTpq1UZwJ0B8nCaqTNAs7iA4x/La5BWBJCDVL1e7eQskv2eVMb7NvjbwirSCcV2Gr3OPpxQ47cltLUZbNyorVdcw+1ZpJVYRvedfMsQU8QoCj3eJO98vDkFLkOQzRSwU5AEK2RtBJaHmylqUF+rLUyzd+Vn6KpfaV2C/s62aU4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773230390; c=relaxed/simple;
	bh=7L05EWimhuh0T0G4AbugcywDE/W3b5BIQqPB/jlupZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZhNi4O+FgWSTFJcoAzkCMxZZX2x3MnoR7V3IJzmCXlry1R+s4NE8Y/Xv65cU04Q9oS70XVg5iRsv4PVDXoEdf+TblpLajERuTBKG0X5Ps1q5virY8FVsKKpG+Bxmg7alXLg92PSECPm5NTORnheS40mhUVAOHHIG4dCalK+yuh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MccQFE2M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MccQFE2M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC756C4CEF7;
	Wed, 11 Mar 2026 11:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773230389;
	bh=7L05EWimhuh0T0G4AbugcywDE/W3b5BIQqPB/jlupZU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MccQFE2MB47oXOOb4mvYNYBpxTNQR8cze+E2vn7aD2JdRxlDSq3tnJm4uKmDlR4T6
	 5jPIeiV1/VylKk2qCrMJGpOH37F69pZS2Hwl2Zn1K84UC89TmwfLM9H6Ksqhp1g3Op
	 805z8YgcDJknSteio4hG1NxOzCW3e4iXA6dDdiICRLOdDbew+9c5Il2eLEiX5foq3Z
	 hAuGezC4BWpfzlMpKOanpQtGKiIuNo9l3zIIJ0dojxN0Vhb0sOU6BZ2k6eHqzjb2Dj
	 xCu389Z1OELcl9epnnGEcoewycabonntx2VEiuSjazqeuOeFd52N4zQ/aNTHIdg0Qg
	 QyH+HM8rnE3cw==
Message-ID: <6624bc37-8a2a-4718-bd03-32382dd28d67@kernel.org>
Date: Wed, 11 Mar 2026 12:59:45 +0100
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/1] mm/pagewalk: don't split device-backed huge pfnmaps
To: "Boone, Max" <mboone@akamai.com>
Cc: Alex Williamson <alex@shazbot.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Tottenham, Max" <mtottenh@akamai.com>, "Hunt, Joshua" <johunt@akamai.com>,
 "Pelland, Matt" <mpelland@akamai.com>
References: <20260309174949.2514565-1-mboone@akamai.com>
 <20260309174949.2514565-2-mboone@akamai.com>
 <51eeb09d-d3f4-412f-85da-690fdc0f8e6a@kernel.org>
 <CH2PR17MB3797A91D5107B6E347EEDD97BF79A@CH2PR17MB3797.namprd17.prod.outlook.com>
 <da2ebc9f-ec82-4c55-851c-b27110efdf8c@kernel.org>
 <83842620-AD01-4619-845F-8DE7DF1F8F31@akamai.com>
 <0a652e7e-339e-4f98-b591-7fe5680e2006@kernel.org>
 <6CBB0401-26DD-4EF9-949C-54BEAD3ABA33@akamai.com>
 <5fb9beef-b6fe-401a-aa24-aade48b795d4@kernel.org>
 <0A734214-9E4B-4A65-AFB1-055883639358@akamai.com>
 <d7f3c613-92f5-4400-812e-a368bee45a41@kernel.org>
 <928CF80F-7436-42ED-9791-F63E3D699CBE@akamai.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <928CF80F-7436-42ED-9791-F63E3D699CBE@akamai.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/11/26 12:14, Boone, Max wrote:
> 
> 
>> On Mar 11, 2026, at 11:45 AM, David Hildenbrand (Arm) <david@kernel.org> wrote:
>>
>> The code in follow_fault_pfn() should likely be updated to handle more
>> than one attempt. That's also what GUP does.
>>
>> Likely, follow_fault_pfn() was never taught about PFNMAP mappings that
>> can be faulted+zapped (in the past they were always static).
>>
>> If you turn that into a (possibly) endless loop, does the problem go away?
> 
> Yep, was just trying that - with this change the problem goes away:
> 
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -532,7 +532,7 @@ static int follow_fault_pfn(struct vm_area_struct *vma, struct mm_struct *mm,
> 
>                 ret = follow_pfnmap_start(&args);
>                 if (ret)
> -                       return ret;
> +                       return -EAGAIN;
>         }

Looks like follow_pfnmap_start() only ever returns -EINVAL: for invalid
parameters (unexpected) and non-present entries.

Returning -ENOENT when there is no actual entry would be clearer. Then
you could just translate -ENOENT to -EAGAIN.

But just always using -EAGAIN should be fine here I guess.

> 
>         if (write_fault && !args.writable)
> 
> —
> 
> I’ll propose that with the VFIO folks when I get the patch for mm/pagewalk.c ready and will refer
> to that patch, or would it be better to propose two commits under the same cover letter?

Probably be best to send two separate patches. One MM fix and one vfio
fix. :)

> 
> I can have a look at follow_fault_pfn but this problem is my first time diving into linux mm
> so that will probably take a while (and some reading up on my end).
No worries, just let me know if you have any questions.

-- 
Cheers,

David
