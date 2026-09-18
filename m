Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B917C294A10
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 08:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789720747; cv=none; b=RIPQi4GipcN3WyUtCENQ8gy0VrljO1Mvq00tRd4bgMaNKGfevw7IQLe7EOiyxEUcf03gB2PeIIeok6+vG+gGqitLFlq1h1EcvcazAK0SmtpLv30MTlWcEn9N1aCOiOGX1CfjZbJm5buAyjkycp23KJp7lXN70fbv5bHZ4EbFINc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789720747; c=relaxed/simple;
	bh=zX+91O276jyoMbgJ5NOf85qR07+N8a63fPpoQPJle6Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=svf6TuCVA/BXFH+UTWa4z4SPCodW2Fjl6BY37w9JOrWnsqAHetWfqjm6qP8v6xCHTEhKkMID4p3Y4o6uqg4TNGcG0Qb1vLyBG1GBKIzBU0afolmM2zCHgJZDL+4Evk8vXdCW9/esPcyfbXzdUpFoEKOQfHeNKI+wBGKIZUYYVtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=df3sVQbG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="df3sVQbG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC8731F000FF;
	Fri, 18 Sep 2026 08:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789720745;
	bh=lt5ed4DVEBDaXQg6ckJXhVkN6pTBsUlsx34l4Py+K8c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=df3sVQbGQL68sALjh/SnV+QM+rYrkBGsD8f1mHM2A9XtVjUdms9pWxRggdL5hZM6C
	 hOjavmzmvjEsrCEMt8oLjRDvedP/gz/V1+KQ2dLf1eM7mcRa7yp8dyvV2tAZ015IPa
	 Ah+hZTWaGSqpelgkG3IHf9QmhEn4DD+w/9zHhwxgxfPmCOxiakfRfXTW5m6im3UK88
	 4Zc7/FGKgrbShECgclhDv0cgmFL01/R8vpO6bwj8s8/2H5Z8l78rPDLVkGLHR5ANjm
	 6+T4cqV7qBgZ0ha8UGpDHbd73JDoTdEw2U0d62hDVNXPC9x0emhS158xYiRZxmxAdJ
	 Qtrj5DOjM3Z8w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 26/28] KVM: x86: selftests: Introduce memory
 protection attributes test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260918081543.139871-27-pbonzini@redhat.com>
References: <20260918081543.139871-1-pbonzini@redhat.com>
 <20260918081543.139871-27-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 08:39:04 +0000
Message-Id: <20260918083904.EC8731F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] selftests: incomplete capability check for KVM_MEMORY_ATTRIBUTE_=
NO_ACCESS
--

commit f041c4a018399e9454f5aa7f797e258a8a617f0e
Author: Paolo Bonzini <pbonzini@redhat.com>

KVM: x86: selftests: Introduce memory protection attributes test

This commit introduces architecture-independent tests for KVM memory
attributes, utilizing small architecture-specific snippets to handle
the execution tests.

> diff --git a/tools/testing/selftests/kvm/memory_attributes.c b/tools/test=
ing/selftests/kvm/memory_attributes.c
> new file mode 100644
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/memory_attributes.c
[ ... ]
> +int main(int argc, char *argv[])
> +{
[ ... ]
> +	struct kvm_vm *vm;
> +
> +	TEST_REQUIRE(kvm_check_cap(KVM_CAP_MEMORY_ATTRIBUTES) &
> +		     KVM_MEMORY_ATTRIBUTE_NO_ACCESS);

[Severity: Medium]
Does this capability check in main() ensure that all required attributes are
supported?

Since KVM_MEMORY_ATTRIBUTE_NO_ACCESS is composed of multiple bits (NR, NW,=
=20
and NX), a bitwise AND evaluates to true even if the kernel only supports a=
=20
single subset attribute.=20

If only partial support is present, wouldn't the test proceed and=20
unconditionally iterate over access_array, where the ioctl to set=20
unsupported attributes fails with -EINVAL and triggers a TEST_ASSERT crash
instead of a graceful skip?

Could this be updated to verify that all bits in the mask are present?

> +
> +	vm =3D __vm_create_with_one_vcpu(&vcpu, pages, guest_code);
> +
> +	/* add a few extra pages for use by tests */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918081543.1398=
71-1-pbonzini@redhat.com?part=3D26
