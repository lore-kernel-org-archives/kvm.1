Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BC83BE15F
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 21:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779917240; cv=pass; b=tEnYexq3fmMTk7snmCweeADFnv9XKYUYUYS4m4pNTTx1NDTswZ1YIORa05ZpVDaIAyIWPQsXloaaykiB1Z5ZVDQvk69Djty7mhFHa1r1X+TtNUmZNlwnsm+Migwo5kML9aYtflt03lzUP4WJ+3MgFP1UpjccRwb0ff2KguGqX60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779917240; c=relaxed/simple;
	bh=YnI+gBEK99o6JW7r8UYKmFh3L1HQLAgpd6bvG/HH9E4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u6hL0iSttRg3pOdwXyQpkEB4CePGGd1NJ4gqpjHQ7+INbBeDXwz812CyyBCyPgAZtaipQ7gkniZa0MpvfhHsI2OmVoqkCbpv3i5Okz26URBOCaPgE7vy1X0C5IWFLcxpF7pzbcycKHgTYIiaWiBStv1eaTjzypvlcldkYSu/wBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BMgoUry0; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BMgoUry0"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-137335bc3caso3125406c88.0
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 14:27:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779917238; cv=none;
        d=google.com; s=arc-20240605;
        b=JZQFl6zuqIhuXiMh7xtpO63wh466a2FYUlfdCwhPKonnEiqNjcBHaMHlAqJK7D+LCT
         2Nr1eRSoY9SvGcC2WTPi8MtFZwyjFgkt6a28VHJ+y2dM/PfkVCZXVZsO75BFqQNUhSg8
         le5kwmP16iP2qboHb7MgJRYQ33u8GplByhRLq4LJnma98mcQvImSidPv0m2AGLcKmihv
         upOeHP5lkfiEyBFSng5F/G57tNTidh/91CvxCueZUqUvNX/XtfrY0KqIG8NBv04WmYpD
         o9qF/8pMZ6CeX0Mg0YamMBX/5u6S2c+GkImWDLoiJRrfX1OxtGwbcGLwMdDuSm2xy1ub
         yU0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:dkim-signature;
        bh=F/ZuWO2enwzknvq47dPTMf2VsoYHccel50P0TNtM8o8=;
        fh=KVy4+j+TE0qJlGnL1oxDtQvAs+ZlkPteDJwxhHS2piY=;
        b=XmAFU/XJupr10Xr5PdAicCczOOscW5OXIiSVCDlWBrS3zs2NTW05Iwui7fIq07Prot
         bt7ZK4mBTNwN+vlgNLNcn0ogTMJOtLxUIaWRF22uUonsouKynauU6yCv3iO9qcYxxrZ6
         x84s5QUdNF1gDhnpGLvJzkmaW+H1tU9YupKo3OIaWvQoJ5XFdvojbg/jHs70lNx6WdP4
         VKJItC9UR1rUc3cNGX2qVa85zMCIwhyrN/6sok9C8rSqsVlPbWzNm1VM81cC9PBQQKUG
         8mHG8LF4gv3h5b9uoNs2jt3aUwi4uIiAD6cHBeATMh3d0jFzUuIlzRPK7sgeSUYjR98V
         8FhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779917238; x=1780522038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F/ZuWO2enwzknvq47dPTMf2VsoYHccel50P0TNtM8o8=;
        b=BMgoUry07/oahVsNJ8TprCxJccdKNmOouavLsbBc5v7rzYYcDc5oE/viUwN4f4G/dp
         Q0SsjNOWlPTRbifFkh95VAYRUPwTdgJDbZeXCNQxvaWN44KN3lxk++9f8t1XFzxsD4WY
         EdFfZ/v3NlymKzvvS8VwClBwKaKKSXykdrJ+QdCzgmf4kf9SfjCYxYcZhzi2dn+TXXvP
         dOQta2qXx074/496K1eCMVKZyrIfNxy+FsoPShnJ+yADAOG+enUJl0Ys2VJYllktaRSd
         eyZSlbNpuERwStK99PfC6Jxt2+U3Nu14wPBU2KuQAZxKg/yKKCc7uqybu4/VBcUnFC2O
         ktfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779917238; x=1780522038;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F/ZuWO2enwzknvq47dPTMf2VsoYHccel50P0TNtM8o8=;
        b=KKdSkwTQYk2Lh0pH/Q1ktyHbKmU0DUD9Glecs6Rh6X0T4G2ZFOhu/3asjEQlJ6B05i
         ogdBHXGWHdHqf4xqZ4WaIA3ucmqBWGeSjGSKwApSh092j2NZ2ZbQsQCE9hT9RLU1MYGA
         ab8a06TOuubdU2+vVVVuYm0M3VBNB7TiEIBoLVOvND3gNUrG2uFjXgL/EuKeBBf7qNSC
         3tiJ/OnaF/HBR1EpOiBqn+afzPLTIuev7yQxvvuYPJeqJOQycS2cOHKcUuGNkL5vHtVi
         0N3K0aWSTSyr+ehIoztnH0qBqmBR2cYVZPWIoUQXpC48JztoUrizMa55yi+hvvcD31oF
         5V3w==
X-Gm-Message-State: AOJu0YwE94adWAoCaQtt3dYp3BXJl3OWFLtDu/gZucCEZ20qiULrnGJB
	vrOuvXOzqYXu4j6JUCV5sg8WXawl88EHo1pKmr0dU6VFjFYaorRpImxmcwegcDCbqQ+SAEqdlpv
	LaxpUMmUzAX6oQ+bHmPTIzEX5IItZtRIih/Xm+R9Nm20utGeKgTcPPaSXxHs=
X-Gm-Gg: Acq92OFNisWLx0A/9rV3l1LXZpvHYswB/rvyJMshS6cc+j8SnBep35HbWh3rGrZL56p
	0WqEHgJ+QH6kZqsAoITBtK1HLg//kzxEAmQP3KRKsVKuynRMUr9HpsJOUe6Oi2xXbDxzNZjILhD
	hDwai80HcivPC7BdN93GX7T6oy2BBTC47tWHzlbCySe4S1RqVAcSkRnkoSst0KxrISt0VOCe0xt
	HwfDr8DARGrMsXuSX5n3aeU33xK5bhtLVagbRmkn36MQt+2htGuzyjnU69dAytfJ2qd31TsPhyj
	6jr0wJdQfD0RAtgYENphfW+2DTdmW0EVUJR0zCkIbMY22biSDJhomvd5xMAj56r3J0d7s8hlabh
	xKEFn1BaU8doLNg==
X-Received: by 2002:a05:701b:4244:10b0:136:9ebf:3bf4 with SMTP id
 a92af1059eb24-1369ebf3db9mr4977619c88.26.1779917237159; Wed, 27 May 2026
 14:27:17 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 27 May 2026 14:27:16 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 27 May 2026 14:27:16 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260523010158.085871F000E9@smtp.kernel.org>
References: <20260522-gmem-inplace-conversion-v7-9-2f0fae496530@google.com> <20260523010158.085871F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 27 May 2026 14:27:16 -0700
X-Gm-Features: AVHnY4LeWdNVBSqlhgtF97xpl5nV7Ce8VnbprWBkeoyFHrkHdvIBUib30cljI7c
Message-ID: <CAEvNRgH9H4o_Hka0fazB9vpPB0FsxWJkzhjEK59XpWeg+d2Xuw@mail.gmail.com>
Subject: Re: [PATCH v7 09/42] KVM: guest_memfd: Add base support for KVM_SET_MEMORY_ATTRIBUTES2
To: sashiko-reviews@lists.linux.dev, 
	Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

sashiko-bot@kernel.org writes:

> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [High] Missing .compat_ioctl for guest_memfd file operations breaks 32-=
bit userspace.
> - [Medium] Silent truncation of 64-bit memory attributes in maple tree st=
orage.
> --
>
> commit 49c89936f50d0c8e067175446db94838144dd770
> Author: Ackerley Tng <ackerleytng@google.com>
>
> KVM: guest_memfd: Add base support for KVM_SET_MEMORY_ATTRIBUTES2
>
> This commit introduces base support for KVM_SET_MEMORY_ATTRIBUTES2 in
> guest_memfd to update memory attributes. It defines the new ioctl and
> its corresponding struct, allowing both read and write operations to
> provide error details to userspace.
>
>> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
>> index 4f7c4824c3a45..91e89b188f583 100644
>> --- a/virt/kvm/guest_memfd.c
>> +++ b/virt/kvm/guest_memfd.c
>> @@ -540,11 +540,125 @@ unsigned long kvm_gmem_get_memory_attributes(stru=
ct kvm *kvm, gfn_t gfn)
> [ ... ]
>> +static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start=
,
>> +				     size_t nr_pages, uint64_t attrs)
>> +{
> [ ... ]
>> +	kvm_gmem_invalidate_begin(inode, start, end);
>> +	mas_store_prealloc(&mas, xa_mk_value(attrs));
>
> [Severity: Medium]
> Could the use of xa_mk_value() here silently truncate the highest bit of =
the
> 64-bit attributes field?
>
> The UAPI defines attributes as a 64-bit integer (__u64), but xa_mk_value(=
)
> takes an unsigned long and shifts it left by 1 to set the lowest bit for
> internal pointer tagging. On a 64-bit system, this restricts the usable
> value to 63 bits. If an attribute ever uses bit 63, it seems it would be
> lost when shifted, contradicting the 64-bit UAPI contract.
>

KVM_MEMORY_ATTRIBUTE_PRIVATE is the only supported memory attribute
now. Let's deal with this if/when guest_memfd gets to bit 63.

>> +	kvm_gmem_invalidate_end(inode, start, end);
>> +out:
>> +	filemap_invalidate_unlock(mapping);
>> +	return r;
>> +}
> [ ... ]
>>  static struct file_operations kvm_gmem_fops =3D {
>>  	.mmap		=3D kvm_gmem_mmap,
>>  	.open		=3D generic_file_open,
>>  	.release	=3D kvm_gmem_release,
>>  	.fallocate	=3D kvm_gmem_fallocate,
>> +	.unlocked_ioctl	=3D kvm_gmem_ioctl,
>
> [Severity: High]
> Does this missing .compat_ioctl handler break 32-bit userspace?
>
> Without a .compat_ioctl handler, 32-bit KVM userspace tasks running on a
> 64-bit kernel will unconditionally receive -ENOTTY when attempting to use
> the new KVM_SET_MEMORY_ATTRIBUTES2 ioctl.
>
> Since the layout of kvm_memory_attributes2 is identical across 32-bit and
> 64-bit architectures (all members are __u64), should this assign
> .compat_ioctl =3D compat_ptr_ioctl to ensure API compatibility for compat
> tasks?
>

guest_memfd intentionally only supports 64-bit.

>>  };
>>
>>  static int kvm_gmem_migrate_folio(struct address_space *mapping,
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522-gmem-inp=
lace-conversion-v7-0-2f0fae496530@google.com?part=3D9
