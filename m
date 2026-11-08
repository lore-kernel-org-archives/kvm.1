Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794098659;
	b=fXTLGFW8BuAKKfCS6ooUhw6lRjSGuH5Z1dhCPzZApxlv5II5UTknplS/H8DwLf8DDJqa
	 iVj4DrWwgmg+g5ExDsheryz+mR+BYNlKCVD8Xzk1TN24zHcjpksj9Zw8lIq9n8Z27kCD/
	 +HhOlr16Et0kfEC8cGToOwxhnEZqffr2/fwFmuFvlnrV6amTArJXYFQQ5J/I8T0SnkIJq
	 86u8kJYmPtyGVSCXvJMRVByy6+Sw/EKmZlGTyj+aCdctmgcLHOMD6ai/gAc7088o8UBLN
	 ZLWF5O5bap/jB83dt1SyzV+Ip8RYLpIN7rSCBbhGXnuZ9Dm/YlFfvoAcNqCxg4YifBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794098659;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=agLjLqsWN6ZOjVtvgq5sywvqL9zG1p8SARsUTKFu1wM=;
	b=ecN1/zkyg5H4pyqR4+ljIwCjRF3WnhDecW7SX5wxEk93yLn3nxfe7vtJROMbUIHbdgzO
	 IWsK9s2HZqFbiakqIUpfOenEfXGUxsTx738RtNF8tgGtLVlDgpfakxkKETmidMkJCF6z7
	 b8q1uo2lVJI1UeL70q81xGhQz1nqTB6RQRN93/EuR0wTww5MbUWgM+I2VfyCCWhC57Svt
	 ES5kcJlacUA8a/7fsd/2q/w8tAkZfsGhLaq17QyuQW5bOOOZ9zm8hy3/5Lw7HOqwHlg3C
	 wE39aVHvzQquEDKGY2y/W5Ycw9BmHS9oJ7RtqotpU2emyubUGohuhc5LvIP0Zvtlrgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S3zYLpBo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A090606D815
	for <kvm@vger.kernel.org>; Sun,  8 Nov 2026 00:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S3zYLpBo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3F981F008A4;
	Sun,  8 Nov 2026 00:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794098658;
	bh=agLjLqsWN6ZOjVtvgq5sywvqL9zG1p8SARsUTKFu1wM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S3zYLpBoPX2iShJUAATU/qD0rEvlW89Ntfn9fHPVRE/YZGi3wp1cYfz2pIg73ZmDY
	 C+CAq9K4qa+mfK2KBY4FxRRaffMtW6yancdnfW4FxuxjRJ4tCil6CAEmebZ7R1Jj3i
	 dS2uY3hUk7XN5PBQWTbtWrfZz2e0zs4VN5utDesl80eKYn2pBKy+L4NdRqbRMiTEAj
	 /8694E7n0tXGN4WDSGj9/MMzIzxasmRGlwrf4u8lh54NGcYRWrSeRG2zY8cYLxbMlb
	 vSCQ20J4uerXbCasc2ZniMOqbIP65N3hmVO89Ajqo0tUBqK9pm5/hMV5QTyaw9xlPA
	 3zsIUjCad7HMw==
Message-ID: <sashiko-outbox-203465@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 54/88] KVM: guest_memfd: Support read and write
 operations and provider callbacks
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
In-Reply-To: <20261106-gmem-alternative-providers-v3-54-8484dde66a7e@google.com>
References: <20261106-gmem-alternative-providers-v3-0-8484dde66a7e@google.com>
 <20261106-gmem-alternative-providers-v3-54-8484dde66a7e@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 00:44:17 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] KVM: guest_memfd: corrupt *ppos on copy_to_user() fault in
  kvm_gmem_rw()
- [Low] KVM: guest_memfd: missing kernel-doc for provider read and write
  callbacks
--

commit e75034915fb7c05a994b62162e0f8d89c6caa18a
Author: Ackerley Tng <ackerleytng@google.com>

KVM: guest_memfd: Support read and write operations and provider callbacks

This commit adds read and write file operations for guest_memfd descriptors,
using a stack bounce buffer to forward shared memory reads and writes to
provider callbacks.

> diff --git a/include/linux/guest_memfd.h b/include/linux/guest_memfd.h
> index cd634576c9af8..c85594b58112a 100644
> --- a/include/linux/guest_memfd.h
> +++ b/include/linux/guest_memfd.h
> @@ -113,6 +113,10 @@ struct guest_memfd_provider_operations {
>  				unsigned long *pfn, size_t *nr_pages);
>  	void (*put_pfn_range)(void *provider, pgoff_t index, size_t nr_pages);
>  	int (*mmap)(void *provider, struct vm_area_struct *vma);
> +	ssize_t (*read)(void *provider, void *buf, size_t count,
> +			loff_t *ppos);
> +	ssize_t (*write)(void *provider, const void *buf, size_t count,
> +			 loff_t *ppos);
>  	int (*check_set_attributes)(void *provider, pgoff_t index,
>  				    size_t nr_pages, u64 attributes);
>  };

[Severity: Low]
struct guest_memfd_provider_operations has a kernel-doc comment block above
it, so adding read and write without @read and @write descriptions triggers
scripts/kernel-doc warnings.

Could the kernel-doc comment also document that these callbacks run under
the shared filemap invalidate lock (so they must not take locks held across
kvm_gmem_revoke()) and are expected to advance *ppos by the number of bytes
transferred?

> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 61a3ff7fcd84c..385b517b49ed5 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c

[ ... ]

> @@ -1204,7 +1239,86 @@ static long kvm_gmem_ioctl(struct file *file, unsi=
gned int ioctl,
>  	}
>  }
> =20
> +static ssize_t kvm_gmem_rw(struct file *file, void __user *buf, size_t c=
ount,
> +			   loff_t *ppos, bool is_write)
> +{

[ ... ]

> +	while (count) {
> +		u8 bounce[256];
> +		size_t chunk =3D min_t(size_t, count, sizeof(bounce));
> +		pgoff_t start =3D *ppos >> PAGE_SHIFT;
> +		pgoff_t end =3D (*ppos + chunk - 1) >> PAGE_SHIFT;
> +		pgoff_t nr_pages =3D end - start + 1;
> +		ssize_t ret;
> +
> +		if (is_write) {
> +			if (copy_from_user(bounce, (const char __user *)buf + total_done, chu=
nk))
> +				return total_done ?: -EFAULT;
> +		}
> +
> +		filemap_invalidate_lock_shared(inode->i_mapping);
> +
> +		if (!kvm_gmem_range_has_attributes(inode, start, nr_pages, 0)) {
> +			filemap_invalidate_unlock_shared(inode->i_mapping);
> +			return total_done ?: -EFAULT;
> +		}
> +
> +		if (is_write)
> +			ret =3D gmem_provider_write(gi, bounce, chunk, ppos);
> +		else
> +			ret =3D gmem_provider_read(gi, bounce, chunk, ppos);
> +
> +		filemap_invalidate_unlock_shared(inode->i_mapping);
> +
> +		if (ret < 0)
> +			return total_done ?: ret;
> +
> +		if (!ret)
> +			break;
> +
> +		if (!is_write) {
> +			if (copy_to_user((char __user *)buf + total_done, bounce, ret))
> +				return total_done ?: -EFAULT;
> +		}

[Severity: Medium]
Does a copy_to_user() fault here leave *ppos advanced past the unread
chunk?

gmem_provider_read() updates *ppos by ret before copy_to_user() runs.  If a
read spanning multiple 256-byte chunks faults in copy_to_user() after an
earlier chunk succeeded (total_done > 0), kvm_gmem_rw() returns total_done
while *ppos has already been incremented by total_done + ret, so ksys_read()
commits the over-advanced offset to file->f_pos and the next sequential read
silently skips ret bytes.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-gmem-alter=
native-providers-v3-0-8484dde66a7e@google.com?part=3D54
