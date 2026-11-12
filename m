Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794520026;
	b=Ul1qHvnxb9ZOQVITrCusfItm2EEWGvAGtlBJpoRws3mL9EBYY8EQm5FL+dzWoBLYMzYf
	 3+/CW+a/4ellvr5GfSgcYQQQpDQnrilQuRYC/2Qf7qQdac7ShxC7feGFdodAq8XIHcf7v
	 vR1NcscSGj89Q3qTTEpGUuAuILCCJUJ9cbdVarJpeGSs5g6q+mIW0jY39ry8V3uHr1uFc
	 aw730LCAL0hMpfQt4Bkj3xbXiAUe/coV2pG6wJrUqUJAfE1UdE3Dvt9FL+YJjpN3xMIqx
	 kqSPudZAsKNxu9oLjKEqeU20JRWBkGInNwXduMrh1QOJndumW3sCeUDYPSRj1c4VZog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794520026;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=MRvrBEIopDqvuVb/vZ72s+DUNbn5hAJVvZTwAj02wNI=;
	b=vyjbQuJ0MhpjgKcGOuZTVqr6Ajxg2rLQPMVQAJQU72vstjJfUbxem5z7Zl5uT68wcsWJ
	 Ei7+AsLrZsEB/HrkfIm6vK+8Tps7R76Du74ldafRZu8KlIqUpafFJssXVdz7Fu3EZhAg0
	 0R2NoRUTZEcKvTY4H33SipkNyA8bFjgkAGS1WfGLw4dg/fVppT19lrT1r5eRSQcGvOI4D
	 TdE1I8X/904UwYJsG7UUtdfpk0/DJZ9KtDTocSOngnfkNRiJFIZdqwiab5JYinZRw1niw
	 g2qrPpkzgAf7+Oo+JirXPDZZwbaeCuvkn7xQG67ACKjdBAsmu3mnToX83kCbNHuy6JA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=IqQicUBc;
	arc=none smtp.remote-ip=209.85.215.169
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924F5606A327
	for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 21:47:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 924F5606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=IqQicUBc
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cdb75699c7cso118761a12.2
        for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 13:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794520026; x=1795124826; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MRvrBEIopDqvuVb/vZ72s+DUNbn5hAJVvZTwAj02wNI=;
        b=IqQicUBcHFfASsPeC/FaWkK7/Crm2L2UYyn8/PxIFh5d3NQfwGTsj1ea0yYEQ647ZV
         /ccaegp04k9hdkyY2Ail6N4rBeUM3LACMz8nX+7douczOTVskMzZJ6rF5iaIrVQm2heW
         JeAJJRZGwbkWIX4oCdCOf9PAKsBXWkvG0Qf/0hEZ5qTZmjRSXZseI6akOjoL+PPSYmfs
         n/o355gYSqEM305OphinxwQkhxOcncDRdESkE1XHs1UYEEh7UGYPCzuqJ/L28TVUC0U6
         aJlfLAOYc0LEA5khjKc7nJefwozvr0lPgi0RdEjsCmQOzXego5h4dYanuiOcrof8EvZv
         aU7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794520026; x=1795124826;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MRvrBEIopDqvuVb/vZ72s+DUNbn5hAJVvZTwAj02wNI=;
        b=JGqhfje/mli/CXuHNFgnkl2KuP5zvLJ/9I/ZnzMlRqii72CRhH5hkwVcFYEekJaIAA
         9XmI/S39/qB/fSgnHjrJBxRK58kH3pWp7B44R4ZoLBcRtmGPo8Rg63FU9hF59TYLU5RV
         yQO/t4p+vvZxwJa+WwMBkhhbThO7ni4T5bkqrJxM55bUIVDOMkRyC7siIE/bHODMgKIp
         KGLc7FAhl4HpSHm7hgOd2OAmBs8lAMWunbg5LBSmQ6Mm5hG5tn4qt2z6VLAm+6OlMguw
         1a/+nUqC1IEJ1Ua+FtUcQ+33fXcWCy3+dxcre6xujcuTf4OXSf3xrVLU12rzhoGyMtGz
         Ys8A==
X-Forwarded-Encrypted: i=1; AL+hErF1E1Rhf+/BkEPQ00j2BxWo7o0DDWoPOoQRaV31Z0xs5NV6h60rjlQnOVb6R0mOSFCZyq4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8XxomO9B5Eqa+UGULBFGplFjoRso3UitpFF91AsmLh2NqyGtDc
	uIpd5bfYw+8whqGZP6cWMV4aodJT6Yx8zGT4drFEzJ8IntOFbL1Xm/FphlKwP+5ZCw==
X-Gm-Gg: AYBFou2UornM3oIX5ZnLXrY+ZfvevXu5K3gQu1maFI3xo9UXHvynd4CHTe+GxXFruCK
	rUMdWSRo6YQwSXojvRpGu8bZn3fKwd2Jzu3VyBxaeUoytSbbyNPawrYwxWu/sk17HxqADFt264m
	Igk/ZHztqzZdlhVs+NWY8Hj3Gwg8Sz+Xddb/PkiySdI/ix+SQT/ZuqfALBhISQPTskl9KeQI5x0
	RtcIZLkG683z+HNrlGa9MLXJ+WxFGzyxvXsIrUUs6IF96KSO00neMmG2cbzct9bp5iSCiuh9t5E
	2ygnRlLaEqNTWFSbjvWedC7oUO6lsDlkogG2QxTel21bapx/fwU87FO5Z7qNK9E0a/oJhCPxe4L
	dKwki9wwM2hlZ8zJWf4aAfz2NVqwHYh1g1XyQpOgoxyw34HuD7H0Zfd2UiFsAXI/H/Jh52Ja2W1
	LQGaEnMWM/6b/GfosCIlOQM9s+8sEuE5hNk3+svHCTjbZUPxm4JtLl3zhunnVrzhJZ/gvtX3dNT
	bQzASRWxj90ULyLGwqwl79EX4CV5e0YXk2UVDZy4Rp+IGx8GF9PWcziteZjDTPPUPNOPSH6I6YC
	t4wJe9/YkzR5z8f8xXHlZdisaugUjYNtdV/MHwePQLIg+ftxmIw6XKaF4ZKou+HKTH/vwSmoJis
	Cimxjr1h5AA==
X-Received: by 2002:a17:90b:30e:b0:3b0:97b8:d6bc with SMTP id 98e67ed59e1d1-3b1b0a0e889mr278699a91.16.1794520025137;
        Thu, 12 Nov 2026 13:47:05 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d257a0sm6493095a91.11.2026.11.12.13.47.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 13:47:04 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Nov 2026 13:47:03 -0800
Message-Id: <DMTK99TDM9AM.SAM3Z4COP9WS@google.com>
Cc: <dri-devel@lists.freedesktop.org>, <iommu@lists.linux.dev>,
 <kvm@vger.kernel.org>, <linaro-mm-sig@lists.linaro.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-media@vger.kernel.org>, <linux-pci@vger.kernel.org>, "Alex
 Williamson" <alex@shazbot.org>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, "Josh Hilke" <jrhilke@google.com>, "Kevin
 Tian" <kevin.tian@intel.com>, "Leon Romanovsky" <leon@kernel.org>, "Logan
 Gunthorpe" <logang@deltatee.com>, "Matt Evans" <mattev@meta.com>, "Matt
 Evans" <matt@ozlabs.org>, "Mina Almasry" <almasrymina@google.com>,
 "Samiullah Khawaja" <skhawaja@google.com>, "Shuah Khan" <shuah@kernel.org>,
 "Sumit Semwal" <sumit.semwal@linaro.org>, "Vipin Sharma"
 <vipinsh@google.com>
Subject: Re: [RFC PATCH 0/7] vfio: selftests: Add peer-to-peer DMA selftest
From: "David Matlack" <dmatlack@google.com>
To: "Alex Mastro" <amastro@fb.com>, "David Matlack" <dmatlack@google.com>
X-Mailer: aerc 0.21.0
References: <20261111192411.4133780-1-dmatlack@google.com>
 <avYjFfqr3T/U7lvn@devgpu015.cco6.facebook.com>
In-Reply-To: <avYjFfqr3T/U7lvn@devgpu015.cco6.facebook.com>

On Thu Nov 12, 2026 at 12:35 PM PST, Alex Mastro wrote:
> Hey David,
>
> On Wed, Nov 11, 2026 at 07:24:04PM +0000, David Matlack wrote:
> =20
>>     Is requiring userspace to re-issue IOMMU_IOAS_MAP_FILE the expected
>>     uAPI behavior? VFIO_DEVICE_RESET (and runtime PM transitions) on the
>>     target device also bracket the reset with
>>     vfio_pci_dma_buf_move(vdev, true) and vfio_pci_dma_buf_move(vdev,
>>     false), tearing down any active IOMMU_IOAS_MAP_FILE mapping of that
>>     device's BAR even though PCI_COMMAND_MEMORY remains enabled when
>>     VFIO_DEVICE_RESET returns.
>
> There was some discussion about this in the thread below. My understandin=
g of
> Jason's point is that the current behavior, and differences between what
> revoking and move-capable importers see in regards to vfio-exported dma-b=
uf is
> somewhat incidental and not necessarily desirable.

Thanks, I will read through that thread. It seemed like a surprising
uAPI.

>
> https://lore.kernel.org/all/arMBqyI4XNfD+q1W@devgpu015.cco6.facebook.com/
>
>>   - Physical target devices and P2P topology checks: mem_bar_descs[]
>>     currently only matches QEMU's pci-testdev, and
>>     vfio_pci_has_p2p_path() does not yet check PCI topology or ACS to
>>     verify that P2P traffic can flow between two physical endpoints.
>>=20
>>     Suggestions on physical target BARs to add to mem_bar_descs[] and on
>>     checking P2P reachability from userspace are welcome.
>
> FWIW, you can also exercise the "P2P" path with just a single device if y=
ou
> IOMMU map a device's BAR into it's own IOAS, and have the device DMA itse=
lf. For
> eventually validating aspects of Live Update, maybe you don't necessarily=
 care
> if an actual peer device is being DMA'd?

The way I designed the P2P selftest support requires 2 things:

 (A) initiator: A device that has a VFIO selftests driver.
 (B) target: A device that can provide a memory BAR (vfio_pci_find_mem_bar(=
)).

So far I haven't found a single device that can do both. But you are
right that theoretically a single device could satisfy both
requirements.

I can relax vfio_pci_has_p2p_path() to allow initiator =3D=3D target.
