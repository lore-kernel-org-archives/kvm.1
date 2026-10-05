Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C4536A367
	for <kvm@vger.kernel.org>; Mon,  5 Oct 2026 21:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791236012; cv=fail; b=UZPPig0dN/2n9j8IZKbHtGPLoAnzBRRd+zCCU5x3aY2EJzzzDgKvJBvalTg9yd3lgssJPlgXMRZVZrVqbKU65gV6GTg5OuWSRkMbf4YkkGHP/kuwzweI53cbDRrqZctvjuh7VLtAzwLjXFDxF0pOMBnoZqyy7VfNR5W1h9u9BsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791236012; c=relaxed/simple;
	bh=02rMi0qsTZ9CbaagY46AZKm77SKpI+WpH1O1AK0qNxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D3JHQHlyQFKbigqBCOJt1tFHdtxmmV48uBga+faWakoRKE4CKV91pSpNJeoJ0cOxIMDmpl6ZZxftp48oR6JSDn39LjYFQlMEMuLkooEOY0uTyEWCoEajktfA9Qthi6T0h+AVDIPx2Qf78nWcRncDnBgpvl+4jY9SW1/Sn/p3HPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=ZM6DHvvK; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="ZM6DHvvK"
Received: from pps.filterd (m0528007.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695IDCU8019097
	for <kvm@vger.kernel.org>; Mon, 5 Oct 2026 14:33:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=DoTDLnxWo+vyBFg2XZXFvqT0SQiCp8iD3nRLl
	DuEKK0=; b=ZM6DHvvKxW2/pC1CNOsB1mPJd6PbhZ1d+WNZzXdBrKg698H4Z/JQ5
	r0k6m6sXmm6aWVzw4PcxIIMpG4KSIKqnAh1JWHxjY4yBbDpwkBvZq8yHY7XYROJW
	qECJPI6+JWo1ArTnAp5BS2i4q4B0I/v7dabXmzWUc6u58Pz8j/TId07ZUViW5zwE
	rMwqm7hZdQ2V3Sg7Xx8zTKqtozkoj7nU3DgmRjKjsh4kBdBlB3eL0I+cq4EJADOU
	4PNzyETYw5o3jQ81IXaTVRrgBpiJ5jVYjWecv1q3ldplR7E9Ohpr5tKJ5mNX7TUu
	8iYh9fuqG8hTKmdAxXx+qEfUjDlqrbhhA==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4h3nqttwww-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Mon, 05 Oct 2026 14:33:30 -0700 (PDT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-815f2b1ecc3so3589676a34.2
        for <kvm@vger.kernel.org>; Mon, 05 Oct 2026 14:33:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791236009; cv=none;
        d=google.com; s=arc-20260327;
        b=kC0bdglKUovb4nv8TLAxyCTCTBwNpuXfyK/liwqcTCi8KKJW+5veQsHmzsk5Ud5SdK
         A2t4JYu07yo7uHFAh9Halk6x1tl7ZP6mCVuoZ8+xbOCrNKeR/KlfW/cVX7U5BmRufmIi
         CiH6Jlf8OEKdDvF6/Ny3p0w1xhMRllLO2MjOQYUsNw659zezYtuxtlt7UpZF92/0PCSX
         abTbD0s9roqxxFb7ObgedBoomCPQaIqi3ZnY7TBn2TYOuZA50GVwHA2sePTfaWyAB1iY
         kgvi7ta2HreNYTkyQZ2WqRInqpFyzWecBiusrhmeSHng49TBD5PwZyjifIOu8WJcAnYz
         Dbqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=ghbzX0NgXdNhpA6B0OeBfQfvRP9XoL8GQxYtfbQBaKM=;
        fh=M2gKZW6TMt9fqTYvlbMfN70saHseD8ALrR7VbaTovp8=;
        b=qM1NTMQk1GaFLsL56d4BSIccK6MndoX38xnvoH+bCKj9smnVLxChOIIGm8+6j2Gzf2
         9QxeWRNBAyRmMqz0S/aFwJ2dOIgIz7LzNFqYJMoicGg5z/jNxVMZAJhfzk5Re7reIdxL
         5R+Ml1ZQBEGQzATXmVFJ339+23SML/Gc87rguumwOwB94pymv63ot2rPXpmjLbl0ejIU
         DSrly5+KAPtJ8TglQFmD3m61SFBxOEWvqt3NG9P5hiZKiittu6DAO9xVJ9LAEz/4Ch4l
         njRbl1f47htbpmEr0RhE6BC5y727W6GslUoRTTXAj0ZergLkg1ka/95dd62bVLCNGIns
         PESg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791236009; x=1791840809;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ghbzX0NgXdNhpA6B0OeBfQfvRP9XoL8GQxYtfbQBaKM=;
        b=s3ETJlU/r1EWCzkZ9xTnJyVdf5jk4PYADH78fjgR/vQrTUJHjuT4kIDivdyyBkTYOd
         n8dinHaRfVtMqqi4Nfi9lMHddFUuY8ky6L556mpbd1LjyuB4OL5REL7a2WjfvcjcFF+t
         kRK4QBdmoJINpNN7b/g+mo/uppPWVH8jFfT3TS/EVnG/LAJINUSBDbvZv6XPWoLGZlX8
         LvWZ8jjKiyvUlQ+mLx8i7ZWduaibQTKY8eDVZF9J+Hys+AavOu1Y34T9X5HMRIHI0uk6
         BJtq7cPPtIYxvXmVzE+5i92oETywtgoB6nKYs06+fTmMtTyCVCPmUCkIA30En9ofxdMd
         DmVQ==
X-Forwarded-Encrypted: i=1; AKwUvBwbdK5yKn+MPBouWihPTyOwqXAY+fYzamkHwNtAlqhs3pTI64qUZH/pVPN7PvFlFLautok=@vger.kernel.org
X-Gm-Message-State: AFuF++kxI0LnRRi6CBfHU1LckeOtXxYfSoXwbORiPlzusiiLWxUY3a50
	NzdsxBR67NTQ28r3Z1VdCKYQLLpS+45d1Wezkte1KMhErLBOQdJGMFPqC5IfEgB4a86ZaFLNi3e
	sDiB3HPLj+uCptjTVZyhcpzL1YXSIsZny7bk67wKefjrtzaGmQc/fldJ3HR9a6td5CZSSBi9k3X
	ykJpY182dRZuC/3Av38kI0ksdlmNQ=
X-Gm-Gg: AYBFou2QKaddUs5OBvSdm79IFUsiJ6rsnQoruWHOnfq7TICUbmPbdGLJZ76klwjE8jz
	YOn3tkepXND4nNzGZ0/x5d5kjqggVZOgngIpkDxFgU+BpSnNKLZjRCvfBb8Vz4wXB+qXlFso6vo
	PfgEHs2cMbkodZX5qoUnmVUVcY12NqFdkZ6yoyxFr6rbpoGJkKp+VgaQHpW/Wnm8K/D1VYNz3P
X-Received: by 2002:a05:6830:67d8:b0:81e:bb4b:2324 with SMTP id 46e09a7af769-82285c55c03mr11907168a34.26.1791236009056;
        Mon, 05 Oct 2026 14:33:29 -0700 (PDT)
X-Received: by 2002:a05:6830:67d8:b0:81e:bb4b:2324 with SMTP id
 46e09a7af769-82285c55c03mr11907148a34.26.1791236008493; Mon, 05 Oct 2026
 14:33:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731211601.3033906-1-zhipingz@meta.com> <20260731211601.3033906-6-zhipingz@meta.com>
 <f4ff7ced-63b6-42e6-8e01-9f01d2e59843@huawei.com> <CAH3zFs24esHCGA=wPrkiH8oKQCv7SnOwcBbkMxrOEvOVtwstYg@mail.gmail.com>
 <20260924233058.GA163130@ziepe.ca> <CAH3zFs2rhg6-b-pVDps1V8LsM4Dn48t4J4LFVyKOZtT4axdY=Q@mail.gmail.com>
 <20260928172939.GK163130@ziepe.ca> <CAH3zFs1mCujYjB=5ywo+huAjPJZQoe9u7NM4evNRYr5_ZQbcXQ@mail.gmail.com>
 <20260930121349.GD3401365@unreal>
In-Reply-To: <20260930121349.GD3401365@unreal>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Mon, 5 Oct 2026 14:33:17 -0700
X-Gm-Features: AclHuK9wPVFlctf6gP5X6sNuMnv1YN3Hk2l0PdMFBVaYzDmHBABydld70Lp-gj0
Message-ID: <CAH3zFs0-5yZzquCAS+RA=jerok3fikWs+hJMnp_91D37ccFtUw@mail.gmail.com>
Subject: Re: [PATCH v13 5/5] RDMA/mlx5: get tph for p2p access when
 registering dma-buf mr
To: Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, fengchengwen <fengchengwen@huawei.com>,
        Michael Guralnik <michaelgur@nvidia.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Konig <christian.koenig@amd.com>,
        Alex Williamson <alex@shazbot.org>,
        Bjorn Helgaas <bhelgaas@google.com>, kvm@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Alistair Popple <apopple@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA4NCBTYWx0ZWRfXxvU+tRsm+sxl
 RjrRJfuxFQ0A5eM6CHrzejIaurJ+/ItrgWX5A22gcYQFJhxg13ES1cR0nrmcRS3T3XfgW4b4t9R
 r7Q7Z/dWT3QwZj7SrW79F5eDjI924W0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA4NCBTYWx0ZWRfX764SDIU7XKWL
 JkOxAcBJDSDsc1LxQoEbb/UhWYJE0eo+bEGtSpAjLfAbxNtFaaamwe9riwP/yr/vSeCSBEnr9Xv
 8ebEENolamDkC60vXYjKcAKKcOpgPK6eML5Czu9Lr3cCGZOlHP8Jcjfq2MCC6n5T9WUGdb0A99g
 CmkobYNlUouqc5jgxylI+BzlAnX99+4IKxkYrmW5LqAQ0qhsjAVCSRt2f1eNevz/qZSGF+lJi0u
 bPCKUrTa5fg30UAv0vE2we+h72xmt9YLEuN/NbXuY0SIRfY7TWAaqCjU5WbO0iiuKTiv/wymZFo
 ntMJpdntIkWZ9FKX2yz4/VtSWzlkVGGwkFVeUlOdu7egg99veZNGBdJqLnRlcatITDYrrxWnfyz
 Yo5C+hb8SarGxYzl9Svu7XiNMcmbA3ftqsHFXHV54AJR42VPm0xDT+DFHH4r5NrubA9XrnoUthO
 z1PPkOvNyom/g5W5nBw==
X-Authority-Analysis: v=2.4 cv=c+o+0h9l c=1 sm=1 tr=0 ts=6ac417aa cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=4h92JMTCafKA-fb_NiOh:22
 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8 a=9jRdOu3wAAAA:8 a=m_M2Mm9OkLXPgJTOvGkA:9
 a=QEXdDO2ut3YA:10 a=eYe2g0i6gJ5uXG_o6N4q:22 a=ZE6KLimJVUuLrTuGpvhn:22
X-Proofpoint-ORIG-GUID: OXDl8GAhSvwPod2KJYAjQQzOGLg8lGdp
X-Proofpoint-GUID: OXDl8GAhSvwPod2KJYAjQQzOGLg8lGdp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01

Hi Leon,

Sure, I'm happy to explain the TPH side. I see you've set the dma-buf
patches aside for now, so I'll just put the requirement on record
rather than ask for a particular API.

On the mlx5 ODP path the mkey must exist before the first dma-buf
mapping, and its ST index and PH are fixed at creation. It's the same
ordering problem you have with ATS. At that point mlx5 needs the ST/PH
tuple and an answer to Jason's question, whether its traffic to the
buffer is routed directly (PCI_P2PDMA_MAP_BUS_ADDR) rather than
through the host bridge. What mlx5 needs there is the answer, not the
exporter's p2pdma_provider. Wherever the route gets computed is fine,
as long as the result comes back for mlx5's own attachment.

In my earlier reply to Jason I said a later attach doesn't change an
existing importer's route. Christian pointed out in the patch 16
thread that it can, because the exporter only commits the access path
when the mapping is created. I was wrong there. The mlx5 patch
re-queries the ST/PH under dmabuf->resv after each
ib_umem_dmabuf_map_pages() and fails the fault if it changed; with
vfio-pci the tuple only changes if the device owner sets a new one.
The route check belongs in the same two places, which I think is close
to what Thomas suggested.

Alistair, adding you for visibility since you're picking up the
mapping-type work after LPC. mlx5 TPH would be the second user of
whatever lands there. I'm happy to help: I can implement the TPH side
on top of it and test on a CX-8 and a peer endpoint behind a PCIe
switch, including analyzer captures of the TLPs, or I can take on a
piece of the work if that's useful.

Thanks,
Zhiping

On Wed, Sep 30, 2026 at 5:13=E2=80=AFAM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> >
> On Mon, Sep 28, 2026 at 02:47:46PM -0700, Zhiping Zhang wrote:
> > On Mon, Sep 28, 2026 at 10:30=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca>=
 wrote:
> > >
> > > >
> > > On Thu, Sep 24, 2026 at 11:17:57PM -0700, Zhiping Zhang wrote:
> > > > On Thu, Sep 24, 2026 at 4:31=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.=
ca> wrote:
> > > > >
> > > > > >
> > > > > On Wed, Sep 23, 2026 at 11:24:56PM -0700, Zhiping Zhang wrote:
> > > > > > I don't think this belongs in the importer. Every in-tree dma-b=
uf
> > > > > > caller of pci_p2pdma_distance() is the exporter, in its .attach,
> > > > > > clearing attach->peer2peer -- amdgpu_dma_buf.c, xe_dma_buf.c,
> > > > > > habanalabs memory.c. There is no importer-side caller.
> > > > >
> > > > > Right, and they shouldn't be doing that, but it still has to be
> > > > > checked that the st is going directly to the peer device not the =
host
> > > > > bridge. Not using the distance, but by the PCI_P2PDMA_MAP_BUS_ADDR
> > > > > indication.
> > > > >
> > > > > I fear you will need some of Leon's series to make that happen.
> > > > >
> > > > > So probably the proposed change to dmabuf ops is far too simple.
> > > > >
> > > > > Jason
> > > >
> > > > Hi Jason,
> > > >
> > > > Thanks for the comments.
> > > >
> > > > Agreed -- the tag should not be handed out unless the routing is
> > > > PCI_P2PDMA_MAP_BUS_ADDR. That can be enforced conservatively on 7.3
> > > > with two changes. I can fold both into patch 4.
> > > > ```
> > > > In drivers/pci/p2pdma.c, make pci_p2pdma_map_type() callable from
> > > > tristate VFIO_PCI_CORE:
> > > >
> > > >     EXPORT_SYMBOL_GPL(pci_p2pdma_map_type);
> > >
> > > No, that's been rejected several times already.
> > >
> > > > and in drivers/vfio/pci/vfio_pci_dmabuf.c,
> > > > vfio_pci_dma_buf_get_pci_tph() gains:
> > > >
> > > >     struct dma_buf_attachment *attach;
> > > >
> > > >     if (list_empty(&dmabuf->attachments))
> > > >         return -EOPNOTSUPP;
> > > >
> > > >     list_for_each_entry(attach, &dmabuf->attachments, node)
> > > >         if (pci_p2pdma_map_type(priv->provider, attach->dev) !=3D
> > > >             PCI_P2PDMA_MAP_BUS_ADDR)
> > > >                 return -EOPNOTSUPP;
> > > > ```
> > >
> > > Also no, this has to be done via PCI_P2PDMA_MAP_BUS_ADDR which also
> > > enforces putting the determination in the right place in the code
> > > flow..
> > >
> > > > Two properties are worth stating explicitly:
> > >
> > > Ah! AI!
> > >
> > > Jason
> >
> > Thanks Jason, I see what you meant by Leon's series now:
> >   https://lore.kernel.org/all/20260928-fix-p2p-acs-v4-0-v8-0-404453b9c4=
35@nvidia.com/
> >
> > Looking at v8, it seems patches 1-4 can stay functionally unchanged,
> > while patch 5 uses dma_buf_p2pdma_map_type() on its own attachment for
> > both the initial TPH query and revalidation. Is that what you expect?
> >
> > If so, would you prefer that I wait for Leon's series and rebase the
> > whole stack on it, or split the series so patches 1-4 can land first
> > and patch 5 follows after Leon's series?
>
> I would like you to join me there and explain to Christian why the
> importer needs access to the exporter's internals.
>
> You are already second user for the same functionally.
>
> Thanks
>
> >
> > Thanks,
> > Zhiping
