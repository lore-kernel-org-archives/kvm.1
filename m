Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209813502B8
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 02:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780539652; cv=none; b=EtpaFVhvXHRanqLJdzlgpwMNkjwxpgfavJi9IPPTgDTciVwG0kgPJonL6X9u7JHzml/Rz6oAb2hFJ4cTYT2X3LAmnARMdOe7tC7e4MGoAcSl3FWfnl+Q3xDdF1h0wPR+nnkGbbBSQS7SeyUOAKxH/EA9jcDs2+MH3W7jL/SP3js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780539652; c=relaxed/simple;
	bh=BxXVzPjDUTfeRHGRV/Gr7/uWAqdzc+VgkPEP7HzaBGE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=A3HPnB4q/m/ICzsIWcKqes3CMq86K+pcDkRMenOVOoHdoj+Nf/rhpnLQEHMu7eY6DsfRVtGLXhyu9s6wF24Zk6JmO+8jvg6VZSUNNRQkwjt3Lb7j4df8x6RgolnR2oKbBxKXs5e+b4O5wCQav/D3GlFRkymBc0WrVSlNegDbem0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PwbmqXp+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PwbmqXp+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A44EB1F00893;
	Thu,  4 Jun 2026 02:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780539649;
	bh=mFpUMFmsPTDsUUlqZ7qSKwXxE2ZCgmZPZy7ge9dM8O4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PwbmqXp+4IUVYkfQm7S8VJfPxcaHw9JmowkFxGEKqWEOdCB/YW4X6YxVl/d789qSz
	 r6OAutDM7AzusYgQNpj+5qfz0Xc2j19/MG5n+RMYaW/EzW9rgEPFZiry/ekUHNjHB9
	 GlmpKBdBquk8FpzrG4SOmpqGtMBQ6fg6J0NxB0got7nDL6wiBlvr0N4GXv2dDdnWhB
	 TaEFGjMAqJrgq9cTnaq9wRPg7k8Tyo3uL/eogkHjeg1mcon9q6ZN4Vsh2cEOHkWtpD
	 lx7vx6KkkZL8ViLvHCwB3Q+AfweJaAo0Uher34rgy1HtoXNFN8ZSfr4/BbhGOhUYSl
	 OOZZfrhnnxIFA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 20/21] KVM: selftests: Make number of vCPUs
 configurable in IRQ test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Josh Hilke" <jrhilke@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260604020143.748245-21-jrhilke@google.com>
References: <20260604020143.748245-21-jrhilke@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 02:20:49 +0000
Message-Id: <20260604022049.A44EB1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing bounds check on user-supplied `nr_vcpus` allows stack bu=
ffer overflows and out-of-bounds global array accesses.
--

commit 115e22303a8d11509c805d6bfdcdbd39b670c16d
Author: David Matlack <dmatlack@google.com>

KVM: selftests: Make number of vCPUs configurable in IRQ test

This commit adds a '-v' flag to tools/testing/selftests/kvm/irq_test.c,
allowing users to configure the number of vCPUs to run in the test.

> diff --git a/tools/testing/selftests/kvm/irq_test.c b/tools/testing/selft=
ests/kvm/irq_test.c
> index 1d66293b6d0b8..41c50caa928e2 100644
> --- a/tools/testing/selftests/kvm/irq_test.c
> +++ b/tools/testing/selftests/kvm/irq_test.c
[ ... ]
> @@ -213,6 +214,9 @@ int main(int argc, char **argv)
>  		case 'n':
>  			use_nmi =3D true;
>  			break;
> +		case 'v':
> +			nr_vcpus =3D atoi_positive("Number of vCPUS", optarg);

[Severity: Medium]
Does this code need a bounds check for nr_vcpus against KVM_MAX_VCPUS?

Because vcpu_threads and vcpus are fixed-size stack arrays in main():

	pthread_t vcpu_threads[KVM_MAX_VCPUS];
	struct kvm_vcpu *vcpus[KVM_MAX_VCPUS];

if the user specifies a value larger than KVM_MAX_VCPUS, won't it cause a
stack buffer overflow when passing vcpus to vm_create_with_vcpus() or
subsequently populating the vcpu_threads array?

> +			break;
>  		case 'h':
>  		default:
>  			help(argv[0]);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604020143.7482=
45-1-jrhilke@google.com?part=3D20
