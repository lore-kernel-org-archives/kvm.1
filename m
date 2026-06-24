Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3089939B49D;
	Wed, 24 Jun 2026 09:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782291622; cv=none; b=XeXIEp0JZZD68jTtA8Ls3sHf8Ou+/sAScCIB5ipcGVVt5dJxfzM/f5fMqcBubyH+ZFxPEt4zFtalI2H+nMVX19odphFfr5Hns9Kug07CCpKMTPOjy6U9y+ltOWo6FF5mm47R4IflfthGLaaTatMPtM1zcb1DDqG2K+OYChI2M/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782291622; c=relaxed/simple;
	bh=L4K9ivM+4+gVc1NLw1F+WL2oVL3+icBZmgGeI06sjMc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CkyduV84hYqCcYhQmfst7YEteBzq1YgsimUVZpl/0Q31SqTtF2ck/Za5mhkqggvbNh7Rbz2+17oKoBMzIb6RS+g52nco4OOqf+DVHdgPPrWQdvsvkHFd6GyS/wX0Dw2E8IlIdSCnTzl1qutIv5EHzd6lDnvIZb949joq8sYgw3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TxiostkA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TxiostkA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 011781F000E9;
	Wed, 24 Jun 2026 09:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782291619;
	bh=Ude7fxjRQOGddru++6y+sDXghtwPibadLNbHTLXVa74=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=TxiostkAILnXpHLtckz/50qP4hggIdYeAhWBv19SYeKJ2UsA9mpyAdTl2uFBwp9WX
	 6rQlhX/86wZJ8Rg/hukqjeLq/PJ1gh5/K5qliq21GuuiBZJOknZm3gm2kjeuggfW/l
	 7tOpYh3yBcXu3rG+ykqiuUCy+IpRbYB3CMPiOsOwmRQ84pZ08UfCoKnydrlLqqs33D
	 sf4VR8FFbsINdyoz2C3WbEtK5Q+bOGPW7hoQKGqc/Y/G4Yw9OdF0ey2rmMxSWsdUGy
	 2suMZpIhzvWsEFTVb3O2MWCoD3i88l/2K7UO6ib4PBq/JWQFVreG/YXusE1z9ZXUOg
	 As5XjdYOpAngg==
From: Pratyush Yadav <pratyush@kernel.org>
To: tarunsahu@google.com
Cc: Pratyush Yadav <pratyush@kernel.org>,  Ackerley Tng
 <ackerleytng@google.com>,  Jonathan Corbet <corbet@lwn.net>,
  vannapurve@google.com,  fvdl@google.com,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Shuah Khan <skhan@linuxfoundation.org>,
  sagis@google.com,  aneesh.kumar@kernel.org,  skhawaja@google.com,
  vipinsh@google.com,  david@redhat.com,  dmatlack@google.com,
  mark.rutland@arm.com,  Paolo Bonzini <pbonzini@redhat.com>,  Mike
 Rapoport <rppt@kernel.org>,  Alexander Graf <graf@amazon.com>,
  seanjc@google.com,  axelrasmussen@google.com,
  linux-kselftest@vger.kernel.org,  kexec@lists.infradead.org,
  linux-kernel@vger.kernel.org,  linux-doc@vger.kernel.org,
  kvm@vger.kernel.org,  linux-mm@kvack.org
Subject: Re: [RFC PATCH v2 06/10] kvm: guest_memfd: Add support for freezing
 and unfreezing mappings
In-Reply-To: <9huzv7b910oe.fsf@tarunix.c.googlers.com> (tarunsahu@google.com's
	message of "Tue, 23 Jun 2026 20:06:41 +0000")
References: <cover.1780676742.git.tarunsahu@google.com>
	<48777f4749fa43d5648085dbb2037aa99c144a88.1780676742.git.tarunsahu@google.com>
	<CAEvNRgFEHciT3T9y+qEYRvXhDwfrggoU7Rm=f9hT3OrV+wgpNQ@mail.gmail.com>
	<9huztsqtmihs.fsf@tarunix.c.googlers.com> <2vxz8q85mdyh.fsf@kernel.org>
	<9huzv7b910oe.fsf@tarunix.c.googlers.com>
Date: Wed, 24 Jun 2026 11:00:14 +0200
Message-ID: <2vxzzf0kl3dt.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jun 23 2026, tarunsahu@google.com wrote:

> Pratyush Yadav <pratyush@kernel.org> writes:
>
>> On Tue, Jun 23 2026, tarunsahu@google.com wrote:
>>
>>> Ackerley Tng <ackerleytng@google.com> writes:
>>>
>>>> Tarun Sahu <tarunsahu@google.com> writes:
>>>>
>>>>>  static long kvm_gmem_fallocate(struct file *file, int mode, loff_t offset,
>>>>>  			       loff_t len)
>>>>>  {
>>>>> +	struct inode *inode = file_inode(file);
>>>>>  	int ret;
>>>>> +	int idx;
>>>>>
>>>>> -	if (!(mode & FALLOC_FL_KEEP_SIZE))
>>>>> -		return -EOPNOTSUPP;
>>>>> +	idx = srcu_read_lock(&kvm_gmem_freeze_srcu);
>>>>> +	if (kvm_gmem_is_frozen(inode)) {
>>>>> +		srcu_read_unlock(&kvm_gmem_freeze_srcu, idx);
>>>>> +		return -EPERM;
>>>>> +	}
>>>>
>>>> fallocate may eventually go to kvm_gmem_get_folio(), so that would check
>>>> kvm_gmem_is_frozen() twice. Is this meant to catch the punch hole case?
>>
>> Yeah, I reckon you can get away with doing this check only in
>> kvm_gmem_get_folio(). Normally you'd like to fail early, but as of now I
>> don't see much of a problem. If you drop the check here and fail in
>> kvm_gmem_get_folio() you'd end up taking and releasing the mapping
>> invalidate_lock, but this isn't a fast path anyway so I don't think it
>> should matter much.
>
> No, Don't agree.
> kvm_gmem_get_folios already have the is_frozen check. which blocks the
> kvm_gmem_allocate. But not kvm_gmem_punch_hole. Your argument is correct
> for kvm_gmem_allocate only. So is_frozen check in fallocate is to
> block the punch hole as well. What ackerley said is correct.

Oh, right. Then we do need the check in both places.

[...]

-- 
Regards,
Pratyush Yadav
