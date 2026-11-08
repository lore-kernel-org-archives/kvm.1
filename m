Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794098650;
	b=rruaf8ic7D8uVVJgeDx0A3UK8XTsz+P1efwUOMuhWEz5v3kPPu+loz6EWw4FtArka49Z
	 j279P/sL1zM9emuAtUJodSiagU9cRap4+nO59uWZLwQMURNoqbyQpA/JbVTcixjAUVYjx
	 DtUo9ed0xQAmlAJ2Wxv0KE4RpOiijRJl1UF0hsHKORXLUsDHAqTlfAN9RYED7HX2DfvYQ
	 fBdoHu2yK5EEPwKWEgn2D0DtpGccAgqgMvjDHAaeamhxlZUSbi+9MBzeWzNarcM/PrdKJ
	 QHXSScYxBaPnE6+aYYM6ckEohhk+9Ta7buNk+vf9Lci0Hmv73X0gGj0r8DYs8fCQLiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794098650;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jaIdnAxJjztQSfWl20YYnBy7sXlg6MoH5xzA2rv/cis=;
	b=dhec/ndw7NKDPABKfzlCyOJrwcxn5vdVjG4kHBrn5vj2J+OzjD0WYKvEuwe52A7a2yCW
	 0G7muJaE5QVT3COIUUKEnY4q4pMIoN4Xl3VSImpmGo2euCV141N2pGOYN+BNc3HzzZuZu
	 ut5OBjuY6PWQRHzstUyX86CWK+G6BiUPfhWKwokdX62+N5odBwNBHrCxYNctr57mNJ7kA
	 wKNGA2whPd+AN7p0iGBGxN0BuFrr7nsGDq66x7ZP4lB/4SzVgIIKdJQnAip0X6ZRDpVpf
	 YHdKPYAqGTGopCmwe1wWc05LBtag7rdNeSahfMQ4O7AOaKhAsr9siy9eu7rIyuWG5uQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y7+mfPjM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92386606A33B
	for <kvm@vger.kernel.org>; Sun,  8 Nov 2026 00:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y7+mfPjM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ABC21F008A5;
	Sun,  8 Nov 2026 00:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794098650;
	bh=jaIdnAxJjztQSfWl20YYnBy7sXlg6MoH5xzA2rv/cis=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y7+mfPjMkcD36IPKM5O3HKPi5KW5XJ5KGR4qHuQU/tNPhGlB7RlgiOf8xjbTaj5Is
	 IsyTy2gsgsPTMLOnAmNGq8aAx1dMtOIqhmsXndQiiENG4m/V3frzswiEUvtVYM7+Mg
	 giABBBpDigt8TxU02+aawn8lHlgRACbsNr16oP4OV5cUN0HXs+hw5H5b6JP6Fvy/0A
	 sBja4AaepR+r4xBId7g6Welp7faBTfEcWVJXS0IGtQE+hybYf6FbHV8h3+nlepz8dO
	 lqvWyQhYG4dDSOtbA0wX7AUChRP9ut7fOy+TBG3q/LBLrItyvya+3CX8lLOF3kBlGH
	 EfAWbXKY3O1aw==
Message-ID: <sashiko-outbox-203455@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 44/88] samples/kvm: Implement attach and release
 provider ops in sample provider
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ackerley Tng" <ackerleytng@google.com>, "Alexey Kardashevskiy" <aik@amd.com>, "Aneesh
 Kumar K.V" <aneesh.kumar@kernel.org>, "Christian Brauner" <brauner@kernel.org>, "David
 Hildenbrand" <david@kernel.org>, "David Woodhouse" <dwmw2@infradead.org>, "Fred
 Griffoul" <fgriffo@amazon.co.uk>, "Jacob Pan" <jacob.pan@linux.microsoft.com>, "Jianxiong
 Gao" <jxgao@google.com>, "John Starks" <John.Starks@microsoft.com>, "Michael
 Roth" <michael.roth@amd.com>, "Paolo Bonzini" <pbonzini@redhat.com>, "Samiullah
 Khawaja" <skhawaja@google.com>, "Sean Christopherson" <seanjc@google.com>, "Suzuki
 K Poulose" <suzuki.poulose@arm.com>, "Tarun Sahu" <tarunsahu@google.com>, "Vishal
 Annapurve" <vannapurve@google.com>, "Xu Yilun" <yilun.xu@linux.intel.com>, "Fuad
 Tabba" <fuad.tabba@linux.dev>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20261106-gmem-alternative-providers-v3-44-8484dde66a7e@google.com>
References: <20261106-gmem-alternative-providers-v3-0-8484dde66a7e@google.com>
 <20261106-gmem-alternative-providers-v3-44-8484dde66a7e@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 00:44:09 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] samples/kvm: build failure when CONFIG_KVM_GUEST_MEMFD is
  disabled
--

commit 5fdcfe92c76b1d01309d2b39a0b5cac375eca5a7
Author: Ackerley Tng <ackerleytng@google.com>

samples/kvm: Implement attach and release provider ops in sample provider

This commit implements the .attach and .release guest_memfd provider
operations in the sample memory provider module and registers them on
mp_file_fops.

> diff --git a/samples/kvm/memory_provider.c b/samples/kvm/memory_provider.c
> index 81ac94ae1a4e9..6f86e3e3262e3 100644
> --- a/samples/kvm/memory_provider.c
> +++ b/samples/kvm/memory_provider.c

[ ... ]

> @@ -161,11 +164,45 @@ static long mp_file_ioctl(struct file *file, unsign=
ed int cmd,
>  	}
>  }
> =20
> +static void *mp_gmem_attach(struct inode *gmem_inode,
> +			    struct file *resource_file)
> +{
> +	struct mp_info *info =3D resource_file->private_data;
> +
> +	mutex_lock(&info->lock);
> +	if (info->gmem_inode) {
> +		mutex_unlock(&info->lock);
> +		return ERR_PTR(-EBUSY);
> +	}
> +	info->gmem_inode =3D gmem_inode;
> +	mutex_unlock(&info->lock);
> +
> +	return get_file(resource_file);
> +}
> +
> +static void mp_gmem_release(void *provider)
> +{
> +	struct file *resource_file =3D provider;
> +	struct mp_info *info =3D resource_file->private_data;
> +
> +	mutex_lock(&info->lock);
> +	info->gmem_inode =3D NULL;
> +	mutex_unlock(&info->lock);
> +
> +	fput(resource_file);
> +}
> +
> +static const struct guest_memfd_provider_operations mp_gmem_provider_ops=
 =3D {
> +	.attach		=3D mp_gmem_attach,
> +	.release	=3D mp_gmem_release,
> +};
> +
>  static const struct file_operations mp_file_fops =3D {
>  	.owner		=3D THIS_MODULE,
>  	.release	=3D mp_file_release,
>  	.unlocked_ioctl	=3D mp_file_ioctl,
>  	.compat_ioctl	=3D compat_ptr_ioctl,
> +	.gmem_provider_ops =3D &mp_gmem_provider_ops,
>  };

[Severity: Low]
Does initializing .gmem_provider_ops on mp_file_fops break the build when
CONFIG_KVM_GUEST_MEMFD is disabled?

struct file_operations only defines gmem_provider_ops under
#ifdef CONFIG_KVM_GUEST_MEMFD, while SAMPLE_KVM_MEMORY_PROVIDER in
samples/Kconfig only depends on CONTIG_ALLOC && X86_64 && m at this point in
the series.  A later patch in the series, commit "samples/kvm: Support
dynamic revocation via kvm_gmem_revoke", adds the KVM_GUEST_MEMFD dependency
to SAMPLE_KVM_MEMORY_PROVIDER; moving that Kconfig dependency here avoids
breaking bisection when CONFIG_KVM_GUEST_MEMFD is not enabled.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-gmem-alter=
native-providers-v3-0-8484dde66a7e@google.com?part=3D44
