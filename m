Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795629804;
	b=4jExfje+pVNFDZsoRoLuT7KYCl5DTcUAPBYFMfsZPHHpVLRHfm5bSjs5/d/12OMxR2fV
	 pOKAOepzJSJnoCZ0ToDslUp8cSrcclR/fVAPyYBszRb4/6hr9sL5pl+/yrtnVV4Nhh9FN
	 BHmR2I8BlaNvgi2gshfj00EIkZeurajIJnDkYlhlrxU95IHWry0/cR6GCojjIIMjWAACX
	 oknNhs+azNnMHcv+P2RTmcz0GYgSjEbZKyQRMXK7UpaOAcaBR0fAU10FLaP//1ib0kKfJ
	 zH/rvAXQuMUpMjoFSX8NnY7y33bhJnpbZCkfbunwGBxlTI8Qi/onMNTan9dOqLgcq6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795629804;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 From:To:Cc:Subject:X-Mailer:References:In-Reply-To;
	bh=X+1AYy7Mp2a7SBL4ePYq/G5iDJIRCdCJCue8L7l5f3k=;
	b=R6PUsc7Ns+UTJAOmaH13LmYUvZ2Wq9S1CIM9BMoYX6PRQ6dzGoMK0gpmcB2c34WLXt4P
	 jtqvS3cHWgaf4F1CRVc51xSrdVXTF39V1cWz4rY0LAUewLAtBixRqddbK44XbBqh7Iuj5
	 M+w6vuxbpjyRvabSov99g3lNgrTbkNjjmmCC5BTHiNHiagillstlnWNct/0+MlGhaMic6
	 qAcQpxjIrlVKJFhLhPuImlA5Sj38KtHpdNh0KCmwJ9xnNYOcW9fflDVpcP76JENoFupym
	 qy+Y6qB2A3NWn+bBdAXEqprnWiMefLZfxAZH/PGgMQSEyNVyHM5W6dn6XhRM3BWRm+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=A95H94SU;
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F7D606A326
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 18:03:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48F7D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=A95H94SU
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2f0464dd6b6so37765905ad.1
        for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 10:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795629804; x=1796234604; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=X+1AYy7Mp2a7SBL4ePYq/G5iDJIRCdCJCue8L7l5f3k=;
        b=A95H94SU9aU41X9Qdw1IDB9XFy9sE+pVMkssDqz5UP6xSP3vg85yutqk/5Ml20CrFx
         8csRNqN1wMi5HgLKS+Za1S6ObBSTEG16G5Wadl0S/zdF+vZuNph+oXSFiv5qjvVqsHCs
         /+QNk36QzE0ZAeuPGsRdGF5/vNYWdE5/DNEYfiPVfRivzQTnSlIiQfpXE+6Nq6HLZQD3
         I726J+6XoLyFWiRRWW1cLvOUnTi4MsweX+FHvrqFfe2XJ9ihDPu8JNrm9da3ym2IIWq1
         QfQY75kYGmaA/GkOicVMnxrkmTt6nz3SpYVpXZRuI34K+WOMApV1T46NwXAed7AlVt8h
         lqMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795629804; x=1796234604;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X+1AYy7Mp2a7SBL4ePYq/G5iDJIRCdCJCue8L7l5f3k=;
        b=OnCILV5BnGQi6mPoWhTuxdZwyA1I9qKywzbqlP2rNaLjYI4/qKu9Gp5BL6faF2DFI5
         UZIYiRyNeCVpet3TL9bTp+7TX5L6qd+FTlviL0dRtS5nf0XypSdXr2GTT1KHVBULQfZp
         0fuTL3wa7vNTYz969davumlQa/JPj1irBV7ZMJdoOvEcp4/BIBF75YfF3HoXhIps5A6q
         RTzgX/Payz06E+BZyJUhHdLh+V7k+h5Zi/JYE5Lkq6IRfZ63wffY7gNmG/r2qsmS7YTC
         dV/WZrcfnIqkXSA/OoYU8u6ijT1jcogDmnch8Kh1U3Z9yjU7I11TahEXn/ay9pDR/bVw
         l3lA==
X-Forwarded-Encrypted: i=1; AL+hErEPkMeeUvxrKZuNlr7dCTbaIJflbn8DcBEOOUa0JdiwCGiiMgFk/2qL9hMtsc8Fyf4okLM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/pd6E0/LCYz2iBOKQK4Va1IyzKlmEIP8zGeAHHOHs0ry2roi4l
	9DpSATYvyFRDg98SDBAOfRntIuj+/ONdEFhSmNHbhDsPNP9Tb283BsP3Cf9HhHa2YQ==
X-Gm-Gg: AZFdTZfW8Y8vpwghzDEK2DRGFMvYc8rIOthkJjsYLlCfu8baT6OhpeN5+Cw9fDJevyn
	Gq9bpXyCL1Emsbmw5RHKwn0gTfpSFCKNZFVaE6C0A5MgChLwrtrv+VvE65n+H9rC7Z8+EqKEt1b
	EjpQmUm78hb7pbvKenVN/sP+WmrnjYXyDrVNbhRGHxPIa/LRbayxw58ZJavL9W6a3qIMEbO+0b9
	g5W+oqHwpoi2j3sd9UEyk8kIUzm1U3r9qX60G4vqSgUeM8zGukXIHrKedFvFe+p0HP7acNncdbM
	GRL/mKpuy0N2IqgigQVZ1n1iMFdHSZFVmXloggaVePWqdIVrxtWfTV/7nI/a1BFEvM4RqQvWGw6
	pOV/HaRxP6Y7qx2RUNSJl/jQFcb+cUKofKE+xzsS2aVNua4b7LcvZ+0i+pldLajH92YDTzaxzcx
	E7KiB/WlGOp9n0czvtNIFR3obyF12SvoP/IH6yJlawaBjZ+mhSvBwPadCI7D6oT0YEiaFT58CHx
	L2eIZHe8D9EZVCzQ/2mnUw93T3puy+4B2NtHcsFcAXoqdLRyLi87rLIyf8i6OJv7bfgDNKu0OwF
	8CsBvWgTMJrbajsbkTwmwc7VaXdK4Lmti/uHL8VdDADe/SkST0JmpkTh01hDZOsLbQ==
X-Received: by 2002:a17:902:f54c:b0:2e8:9820:80cf with SMTP id d9443c01a7336-2f03f1cfbe5mr188390265ad.58.1795629802894;
        Wed, 25 Nov 2026 10:03:22 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f14a432sm91361725ad.75.2026.11.25.10.03.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 10:03:21 -0800 (PST)
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
Date: Wed, 25 Nov 2026 10:03:21 -0800
Message-Id: <DN4HN2W6ZVES.289H6BZD9U7KB@google.com>
From: "David Matlack" <dmatlack@google.com>
To: "Vipin Sharma" <vipinsh@google.com>, "David Matlack"
 <dmatlack@google.com>
Cc: <kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <kvm@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-kselftest@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <ajayachandra@nvidia.com>, <alex@shazbot.org>, <amastro@fb.com>,
 <ankita@nvidia.com>, <apopple@nvidia.com>, <bhelgaas@google.com>,
 <chrisl@kernel.org>, <christian.koenig@amd.com>, <corbet@lwn.net>,
 <graf@amazon.com>, <jacob.pan@linux.microsoft.com>, <jgg@nvidia.com>,
 <jgg@ziepe.ca>, <jrhilke@google.com>, <julianr@linux.ibm.com>,
 <kees@kernel.org>, <kevin.tian@intel.com>, <leon@kernel.org>,
 <leonro@nvidia.com>, <lukas@wunner.de>, <mattev@meta.com>,
 <michal.winiarski@intel.com>, <parav@nvidia.com>,
 <pasha.tatashin@soleen.com>, <praan@google.com>, <pratyush@kernel.org>,
 <rananta@google.com>, <rdunlap@infradead.org>, <rientjes@google.com>,
 <rodrigo.vivi@intel.com>, <rppt@kernel.org>, <saeedm@nvidia.com>,
 <schnelle@linux.ibm.com>, <skhan@linuxfoundation.org>,
 <skhawaja@google.com>, <vivek.kasireddy@intel.com>, <witu@nvidia.com>,
 <yanjun.zhu@linux.dev>, <yi.l.liu@intel.com>
Subject: Re: [PATCH v6 07/27] vfio/pci: Preserve vfio-pci device files
 across Live Update
X-Mailer: aerc 0.21.0
References: <20261102153656.1431701-1-vipinsh@google.com>
 <20261102153656.1431701-8-vipinsh@google.com> <auzftbPFO_6XBYVw@google.com>
 <20261117220059.GA2250529.vipinsh@google.com>
 <DMZLLYOVIGOU.1RXWYJN6UQTM@google.com>
 <20261124234830.GB3545683.vipinsh@google.com>
In-Reply-To: <20261124234830.GB3545683.vipinsh@google.com>

On Tue Nov 24, 2026 at 4:22 PM PST, Vipin Sharma wrote:
> On Thu, Nov 19, 2026 at 04:06:38PM -0800, David Matlack wrote:
>> The incoming kernel computes its own virt[] and write[] masks and
>> requires both to match exactly with what's in vfio_pci_core_device_ser,
>> otherwise it fails the retrieve. On take-over it uses the preserved
>> value for bits in virt and its own freshly initialized value for the
>> rest, like your option 1.
>
> For now, we will be rejecting any changes and in future when we add
> userspace opt-in mechanism then we can loosen this check, am I right?

Yes, any difference fails the retrieve.

I don't think the opt-in would loosen the check. What changes is the
masks the incoming kernel expects: it builds its emulation for the
device with the opt-in bits recorded in struct vfio_pci_core_device_ser,
so a device that opted in to new emulation still matches. Devices that
didn't opt in get the baseline emulation and keep matching older
kernels.

Separately, if we later find specific differences that are safe to
accept (e.g. a newer kernel allowing writes to a bit that used to be
read-only), we could relax the comparison for those. But that's
independent of the opt-in.
