Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BC53597B
	for <kvm@vger.kernel.org>; Sat, 23 May 2026 12:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779540534; cv=none; b=uIrQTTgZ7eYy5DhGouHlOzARCJqGPMWyQRKfhIkteiPmIn+Yuze2iADQdifcdbns6vk/v6BPP0k8qKDiuILrbzsPlR0aQ/kri6ALCCa18ti4cYpHVunsYgH3qs2VyrrsXcHjbEWo2BC+fOyACS6m9si7+PqPDbOwLreozBL20gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779540534; c=relaxed/simple;
	bh=oZfEb1SY+94pBoRb85izS6qyJnRloafYR1oT72QTBnA=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mkr+NGqzSBrF3YtQxwOXEZXbiMPgHHZpau51jm0WsYsq4L8XXzPRwr9NM4ygDQaFeRkOPafSsKRtVYBmNJ4v3UsrQxrgwO6EUFblvU0v2LXC8996XJy1dRuiamRmYUoeZwDpHxC2j0G9szoHCwZY2O3DpQdwFvSWrerMonJQQIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k8c14zqZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8c14zqZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 102E61F000E9
	for <kvm@vger.kernel.org>; Sat, 23 May 2026 12:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779540533;
	bh=bEBfcGCc5fNiULy8PHycH5pbqO+vmw0AzZkmwMFqEus=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=k8c14zqZjzuzjRAwhvivwAk7lKOaULbc6Jrh4zXj/U0Mw2KyqjoFmDuNGnuLj/yvf
	 EG6J/Ff4/UB6hiuimFjVz5r1nACBexZldn6loZ9f1gxsKXMa8+fjC9SPjt3fX1MEuh
	 6xGYrfGaUsas9dzS1uKRVsbb0I3r8Jmj67dX4eGqLMnf63BAjinZ9UgZQ5S3J2S05Q
	 60sQIjKkfm6tplxv0uLLO7Gt/UwpucVE1uL4N1MOH9+SH7IzGpMkvSDOApmcwzVD2F
	 bJ5ruX0bUG641fEktkrICdNEx2yfIV/to7BdXFJNRto4Efy4CYdfOMUnURm5j8PkmT
	 2aJ+Kdj8Memdw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC v2 5/5] KVM: selftests: Print the vcpu_id when
 KVM_CREATE_VCPU ioctl fails
Reply-To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
In-Reply-To: <12184d5eda089814659d5a861b3ebc30d42733a3.1779524962.git.ritesh.list@gmail.com>
References: <12184d5eda089814659d5a861b3ebc30d42733a3.1779524962.git.ritesh.list@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 23 May 2026 12:48:52 +0000
Message-Id: <20260523124853.102E61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The added `pr_info()` call clobbers the global `errno` variable =
before it can be read by the `TEST_ASSERT_VM_VCPU_IOCTL()` macro.
--

commit 9022e7c111e4121ff5a4ed4a90dcbfd2df0a62cd
Author: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

KVM: selftests: Print the vcpu_id when KVM_CREATE_VCPU ioctl fails

This commit adds a debug print statement to display the vcpu_id and errno
when the KVM_CREATE_VCPU ioctl fails.

> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/s=
elftests/kvm/lib/kvm_util.c
> index 0dc67c1502cfb..6a0ee68036236 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -1354,6 +1354,9 @@ struct kvm_vcpu *__vm_vcpu_add(struct kvm_vm *vm, u=
32 vcpu_id)
>  	vcpu->vm =3D vm;
>  	vcpu->id =3D vcpu_id;
>  	vcpu->fd =3D __vm_ioctl(vm, KVM_CREATE_VCPU, (void *)(unsigned long)vcp=
u_id);
> +	if (vcpu->fd < 0)
> +		pr_info("Failed KVM_CREATE_VCPU for vcpu_id %u with errno %d\n",
> +			vcpu_id, errno);
>  	TEST_ASSERT_VM_VCPU_IOCTL(vcpu->fd >=3D 0, KVM_CREATE_VCPU, vcpu->fd, v=
m);

[Severity: Medium]
Does this pr_info() call clobber errno before it can be evaluated by
TEST_ASSERT_VM_VCPU_IOCTL()?

Since pr_info() uses standard C library print functions, it can modify errno
internally even on success. TEST_ASSERT_VM_VCPU_IOCTL() captures errno
to detect specific failure modes and to format the assertion error message.

Could this cause the test framework to print an incorrect error code or
bypass checks like dead VM detection when KVM_CREATE_VCPU fails?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1779524962.gi=
t.ritesh.list@gmail.com?part=3D5
