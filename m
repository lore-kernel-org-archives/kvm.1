Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E80E47F2FC
	for <kvm@vger.kernel.org>; Tue,  9 Jun 2026 15:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781018926; cv=none; b=R24itZs8tIM/iZSddQkRoiDJmlrQJyumxRBNCEg/BbIlmAOC9R+FJOS+hRSrZiv7NOo7iB8wkUlZNPVKtqjoxqelannB3mO6GBfafyFMyYC49Bh0zVN/foalsEjf8g09sclJZo3oOEBqUxq28muUny0bcNt6h5DxhrwKILUDHHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781018926; c=relaxed/simple;
	bh=TOMDBXWIYtrqisfmo8kkBrqACf4YNkH1GsmGxH8D7s4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FBUXqPeNGpemYnt/4Ma+2IfbCtmcRfaCvNhTKI2BarHQhO00vgHcfsk0cYoxkiBgBBkxzBrzluFXBZWQ22Dcb4d+N2tzMgRxFAUz/yBcvx8DJ1QQifMwyPtfQ438rnZyknXN/7iCd2cxtGYChNMkIDvZR2mmhxSKNsipZnqSwfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKTDvF1v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKTDvF1v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A0F01F00893;
	Tue,  9 Jun 2026 15:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781018924;
	bh=vS3VxLdBtLZ2QmZuru+XX09pzIY36HnbD46fnDk0gys=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AKTDvF1vzw97HFN+h61HVuys/IQWh5JCfxyWuOqk+bAWJWJGp+eNX8Ko9h8v0g0c9
	 jq9m43K6cgp3r2yj9TWqCXLc/yqiblvy+3TEjNW6hUCtUR0uYsFK754OWurz7l2KVw
	 t/kxFKQ7e+lGN7r3/9RnnE02wkgsE+gMKR9F2WaueRxPbY4Rz7lygXNGWImc63sddc
	 CVja3sDoNKMAGBXYwdUyuUDhr8QMJn1ACLM5wDqMzzJnsT0LPf6aZChHa3FzXXml4A
	 NapaJZkZh4p3ObCb86swsIZ1yAsntrcaQAr59bxnYbWZeg1ddw69QsO5q6NVwO1X7u
	 r0hTXtudDuxOQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] KVM: s390: Add capability to support 2G
 hugepages
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260609150930.665370-3-imbrenda@linux.ibm.com>
References: <20260609150930.665370-3-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 15:28:43 +0000
Message-Id: <20260609152844.7A0F01F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Userspace can bypass the mutual exclusion between CMMA and huge pa=
ges (1M/2G) by enabling huge pages first, and then enabling CMMA.
--

commit 18ee7269cd4f70997be26c3321bdbc7d2cc63a95
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Add capability to support 2G hugepages

This commit adds KVM_CAP_S390_HPAGE_2G to signal to userspace that 2G
hugepages may be used to back the guest. It implements the underlying
GMAP_FLAG_ALLOW_HPAGE_2G flag and propagates it through the guest gmap.

> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 801a622691b6a..616d1db7c0d9e 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c

[ ... ]

> @@ -901,6 +906,27 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm, struct =
kvm_enable_cap *cap)
>  		VM_EVENT(kvm, 3, "ENABLE: CAP_S390_HPAGE %s",
>  			 r ? "(not available)" : "(success)");
>  		break;
> +	case KVM_CAP_S390_HPAGE_2G:
> +		mutex_lock(&kvm->lock);
> +		if (kvm->created_vcpus) {
> +			r =3D -EBUSY;
> +		} else if (!hpage_2g || kvm->arch.use_cmma || kvm_is_ucontrol(kvm)) {

[Severity: High]
This is a pre-existing issue, but does KVM_S390_VM_MEM_ENABLE_CMMA allow
userspace to bypass this mutual exclusion?

While this handler correctly rejects the capability if kvm->arch.use_cmma
is already set, the inverse path in kvm_s390_set_mem_control() for
KVM_S390_VM_MEM_ENABLE_CMMA unconditionally sets kvm->arch.use_cmma =3D 1
without verifying if huge pages have been allowed:

kvm_s390_set_mem_control() {
...
        case KVM_S390_VM_MEM_ENABLE_CMMA:
...
                kvm->arch.use_cmma =3D 1;
...
}

Since both ioctls only require that no vCPUs have been created, could
userspace bypass this safety restriction by enabling huge pages first, and
then enabling CMMA?

If so, this might allow the VM to run in an invalid state where the hardware
is instructed to use CMMA on huge pages, potentially leading to issues when
it attempts to access non-existent 4K Page Status Table Entries.

> +			r =3D -EINVAL;
> +		} else {
> +			r =3D 0;
> +			set_bit(GMAP_FLAG_ALLOW_HPAGE_2G, &kvm->arch.gmap->flags);
> +			/*
> +			 * We might have to create fake 4k page
> +			 * tables. To avoid that the hardware works on
> +			 * stale PGSTEs, we emulate these instructions.
> +			 */
> +			kvm->arch.use_skf =3D 0;
> +			kvm->arch.use_pfmfi =3D 0;
> +		}
> +		mutex_unlock(&kvm->lock);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609150930.6653=
70-1-imbrenda@linux.ibm.com?part=3D2
