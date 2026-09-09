Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367F74CC27C
	for <kvm@vger.kernel.org>; Wed,  9 Sep 2026 11:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788952851; cv=pass; b=q271JbGRGWZBMRue8WR3A10iEo2f3iqcVAxhi6cNF6Fx5OiGWAioJJLUr/SQI3Mr/6SqAZlOFM8AqRI++S5N3rg9MJX9Ju4ErHo+MGbsTBF/O/UWwnx84pHu4N/SXSH5/w8+awmEmlJEtKvMzFKPCKXRe7JIQv3BpJOKRCL+ki8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788952851; c=relaxed/simple;
	bh=DGJNGDyqk/L8FuMkKQ9UZ8lh0gD+ZC6OA/bClDuW/zs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VsBnE+i9TldtRpcQwAldm3sWHGDAr0rKhk+WdMYLjBubDcpVs1QIaLFLIJqbCV/1SdYnK6zV8RJpO6ZuP8naob7hJZV71abtDq8hkgcT6tf/QGVOHN8japk2u43HWl+iFbscCupVd8JgkDeZNJwISENjFJFU34EyBXc1NZM1eus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QkAL6QIS; arc=pass smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QkAL6QIS"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b4a0b384c4so5880e87.1
        for <kvm@vger.kernel.org>; Wed, 09 Sep 2026 04:20:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788952846; cv=none;
        d=google.com; s=arc-20260327;
        b=Sw4G2A/EhpGwOdB2RwpZhWx/2ynAL5SOl36gcAQHIfPR6m9zCpRcXJYUBdq1Mh3OdU
         LsrO295y30cpzeThJE9y1Cb1i0anMTm8f/yxvvhs/GCr5FjEMP4ZoWFfNPBKu5Sfc9sQ
         QYEqsG68rAMpZD5SMvOK/qAyut7HdX8gWJxQQCHwvFmwH6DeP6aSnI/9ZQn30bEYXJB4
         MTo+bfCmD0oNcxADNEv+AelARbv13nwiwzJ5NWBV9QoieMIU/alCnVqlkPQE/exBdEwT
         pl8ky///6d9YmQSVCMGI7puc8lyxIOMRojjQ8ktJNPW0K1hRkrBQV7jQ+knNkM0o3nfo
         k8PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=crDfVMRTURCJ2kMvoxcTffnKsS81n5x7VpWJfYEfCY0=;
        fh=Ez8NpNZlYpJMs5FsbI2d5a16stCZJhW3aTDCQxMMJyU=;
        b=QSj6gGJJke3fg33l6yZvz1TKnvlaAademv/iQ8SNKxnz+Jar2A3OmIOX6RSaOl8d+o
         PRBK5jpTTkSkHbgJ2QjX7IVk30GqZMf7EVuz2u6SbFjEBQyqdWQe+K/YrNCWecimLo3c
         W9RQJbwORgxfLh5P3cW5Vl7pWvIP2ny5EZKt4dcya79xy2HjDT7NqRAExjedzf083Npi
         38ssnmyu/HexamnML3nKaPQavFUHRy2eIUUUdEycTwhVlKEnZs4Rh0o7tKhEB0AhG3vj
         f5O3adKzI+eLApKwfWP+1AqceOG3aIbgAM3G/9l9+ylENUVScblzX80gufvoRayphdL6
         SeQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788952846; x=1789557646; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=crDfVMRTURCJ2kMvoxcTffnKsS81n5x7VpWJfYEfCY0=;
        b=QkAL6QISn1bh3pjiycL1GsW/qqnPUqacyQ8OWDyNNxDVAKlYUulyikewz0sOsfWFpF
         mU7nyNB48lrWJXC0CGBhPw4Bu81utFNuY1RkyH3dJWSfXY9hjyal5xFdjdHQN6SQBGvk
         BhXchPSZPwI7wOE0rpTx1cUhShbR1U9xG7vxqKyAB10FruuGdkgjvbXcFdVNS3CPMKi/
         UKpq9g9lZcraCJ1vyxaA+6yCc6xUya/N/0qGGQ6GXFV25gYuGkoEtco2uL4PlmVa20Kj
         sMb0fX33vEk0Ecbry2QRhtC1zRcQPng6uL90l87DAeAMudopA+lsY3i6uYn5AKYLJ6sh
         VPCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788952846; x=1789557646;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=crDfVMRTURCJ2kMvoxcTffnKsS81n5x7VpWJfYEfCY0=;
        b=UKgskMlzbRQWNLHdsdtEqkwk24QPkqJo67H+Xb6ieiTKxAr1WI3KHAjzwDbNNsHrrL
         8Fm0enXOnOILm7zJs4jIQLWoK1rm8ZuDu73UpHrCbrXO2LKNe2V5QfaGBTPsPNBVn1G6
         HTZiL2gaOEoJab9cRbEoza0SmfdjsRDoe6MniieuBx/vUeuI7f7gmnSkoQRYvKXzODS7
         9RPrlYfr2tB0OTgv8wxo8yPb2dwGdIM8ZaCMitPkD2/Fq/9XhXfYz3Q3khUe6E9QQ1xp
         3Zx+RszxGdc2nrFS/pnEzr6S52DaWx4sSdvIEgmp0qT0I2LsmCJaRbVA1+1GUU8h/G06
         hgtA==
X-Gm-Message-State: AFuF++mCuInoWsC/2Nc5U70TYy4RKGAswj5ngLwRZfJh7So0GBz0oZBN
	xC4lfDBqmydgdARgq3nbpO0wPcp3f7FOWpLZi1dC7I/9q+ls9EoRz/WhoPOiCd7i/omFm0ixRaA
	J5SYp1SCW0biw/cJJWbR/tGwtlK524Q08cSepKI1n
X-Gm-Gg: AYBFou2LIi3zrk/zFc4Fxc/DyxhcaJ7n3kdRClhRN504gPPzqlABK7vybEratQ4zqrZ
	h9RZddEvO4caRNB+tjj582jnJcG+geXWo7edzgQrY+Xp0oA6Cy9Uot3hw0hcjhY89TTnVZobwmH
	0jBZqDn1qkucTPwNahWZihxzkXjiEubV1/qOw2/S+nDGTBQjuP806oCScSn9bumTqXlA25YtUqj
	wrHSuF3Bz71XLg1Zgk4S1/UQI+dsNP2kO1MB2IduLc+FMeVTAufRs2WT+1kRbn2L/Nt8gtdkP3v
	RNvLw7piFWpfOCsUY7P4UQuirnpVtP6V4ubvFvj0aWg5cjCU3QFV+ND046iruiuAADKG2tWoVrX
	mZCGRJ/E99yc=
X-Received: by 2002:a05:6512:3f22:b0:5b5:e890:1953 with SMTP id
 2adb3069b0e04-5b764bcde12mr149151e87.12.1788952845618; Wed, 09 Sep 2026
 04:20:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908162223.1683432-1-suzuki.poulose@arm.com> <20260908162223.1683432-2-suzuki.poulose@arm.com>
In-Reply-To: <20260908162223.1683432-2-suzuki.poulose@arm.com>
From: Fuad Tabba <tabba@google.com>
Date: Wed, 9 Sep 2026 12:20:09 +0100
X-Gm-Features: AcwNN1UBL7PwhavrAXm1ihvLqEvgnaWmqxzjHA3KjiWz2CvXQREmUKFugkp-B-A
Message-ID: <CA+EHjTwSwGUGT=6GWaOyav7kBQey0+xpL0kJ03ABtp23ZgD6RA@mail.gmail.com>
Subject: Re: [PATCH v17 01/20] KVM: arm64: Include kvm_emulate.h in kvm/arm_psci.h
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, maz@kernel.org, 
	will@kernel.org, catalin.marinas@arm.com, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, steven.price@arm.com, 
	aneesh.kumar@kernel.org, oupton@kernel.org, gshan@redhat.com, 
	joey.gouly@arm.com, yuzenghui@huawei.com, linux-coco@lists.linux.dev, 
	gankulkarni@os.amperecomputing.com, sdonthineni@nvidia.com, 
	alpergun@google.com, fj0570is@fujitsu.com, WeiLin.Chang@arm.com, 
	lpieralisi@kernel.org, enju.kohei@fujitsu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 8 Sept 2026 at 17:22, Suzuki K Poulose <suzuki.poulose@arm.com> wro=
te:
>
> Fix a potential build error (like below, when asm/kvm_emulate.h gets
> included after the kvm/arm_psci.h) by including the missing header file
> in kvm/arm_psci.h:
>
> ./include/kvm/arm_psci.h: In function =E2=80=98kvm_psci_version=E2=80=99:
> ./include/kvm/arm_psci.h:29:13: error: implicit declaration of function
>    =E2=80=98vcpu_has_feature=E2=80=99; did you mean =E2=80=98cpu_have_fea=
ture=E2=80=99? [-Werror=3Dimplicit-function-declaration]
>    29 |         if (vcpu_has_feature(vcpu, KVM_ARM_VCPU_PSCI_0_2)) {
>                  |             ^~~~~~~~~~~~~~~~
>                                |             cpu_have_feature
>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Steven Price <steven.price@arm.com>

Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>

Cheers,
/fuad
> ---
>  include/kvm/arm_psci.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/include/kvm/arm_psci.h b/include/kvm/arm_psci.h
> index f86a006d67136..06c20612e9e7d 100644
> --- a/include/kvm/arm_psci.h
> +++ b/include/kvm/arm_psci.h
> @@ -10,6 +10,8 @@
>  #include <linux/kvm_host.h>
>  #include <uapi/linux/psci.h>
>
> +#include <asm/kvm_emulate.h>
> +
>  #define KVM_ARM_PSCI_0_1       PSCI_VERSION(0, 1)
>  #define KVM_ARM_PSCI_0_2       PSCI_VERSION(0, 2)
>  #define KVM_ARM_PSCI_1_0       PSCI_VERSION(1, 0)
> --
> 2.43.0
>
