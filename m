Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC47B3EAC86
	for <kvm@vger.kernel.org>; Tue,  9 Jun 2026 23:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781048356; cv=fail; b=HnUx3PV1RETR1K8gsdEvOYF82sOuGRXkANdXfCrFsxWaQL2UD56tBbkrfcClnAlVmbru8ZGP1sSk1wvT0HOma+8p4/yXnndbDNOKFpjcO55MYCd1LSVKpPLMqxvz2j8+csPjBxpUp+qaeAafDC/DozxhAyt9mlMwo54TghjQrFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781048356; c=relaxed/simple;
	bh=GJd2gJZmlAgFMCFkHrHwJ2yIaE6MPUQzzzENfnpUb+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TfCVhnkyGvrZ/xCWA51QWlmvnFrBnIVFp6n927099DjAAPoEvKFJHBBm6lLGmX4fYusPgh2Sb4m//RHkBWAAr2ucgHWf+EkwOwRzeIFm79/6rT6skieJHPTdsJJ8uGPXTshQOpeFYztX6BV8WJw4YMuSRjfYHzvzb/R07YakHA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=GcJ+PaQl; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="GcJ+PaQl"
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 659Hhb4J506390
	for <kvm@vger.kernel.org>; Tue, 9 Jun 2026 16:39:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=GJd2gJZmlAgFMCFkHrHwJ2yIaE6MPUQzzzENfnpUb+A=; b=GcJ+PaQlVJQW
	/QiaOOTC0nYPA6Pp1uWg5Nw0lxfOPK46wy3QRjqt6HHI/s8hYflLqOpkQeAGxxLh
	hoyKhwGK2JX4YooWC50qu5EDWSMax2nyL/oD/rrE9huRAKUD3dcFOCQPD6EbqIBe
	/w0OyjcqD5OfnfePJGKHwyaQUFmf3+Tzo3fYXQ5XrBU7OcozGO9AnrRjAwvSdxcY
	Crl7znQ4/d1k0Z7Rho184bTWuJJxHxuMZzLmmMtWby4mzLYkfL9hkRHA6cnRmNak
	77cxz9A7UldkmH6wLB52VlDZREdWuq79DRuezb/llSLMmzA0JKqEm6HamQd79ptg
	ldQYgc2yiw==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by m0089730.ppops.net (PPS) with ESMTPS id 4epqfvtbg4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Tue, 09 Jun 2026 16:39:12 -0700 (PDT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7e6ed99b9b4so13654825a34.3
        for <kvm@vger.kernel.org>; Tue, 09 Jun 2026 16:39:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781048352; cv=none;
        d=google.com; s=arc-20240605;
        b=Q01hwaB5Ci339ZCi282hKqOemxBHK7xrt5RExpbb56zgInWy0PgCrRq3TLUCL2gy2D
         xsAwpVPFdH7XaoC+rJtW1a31S5r/AZvfG+hqbHi9Yni7K/izZhR49dExnH5LAMsDF426
         OMI2N2QOa2L7h6AvJf+nwO/7B83G5AW+YxTd9eggm9OUT9gK63dP/vnEr0N1qw1ZeO+0
         sxUyeT8KUBvJ5pZPLwZTqhe/POZ/dEMG26gOCIIS3qNKuOzRz1JZHQyC8m3xP+DjImSc
         vlGkkG71CvFdqEtNsMb43t2lYEWdKYi68hz43gWDKvFO+ufr/fTXfxldbRbBg+vt8b9K
         ramQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=VHRS+sWMPwoxZ0n+tLXpfsQUcezlTBJw4Sj0yHIKfGE=;
        fh=//y1QyxObua293prOadqTZlwGlBTeDqJQD/jl/yG6RQ=;
        b=CYnYNKQ/3rwlKx/c42HHWBusAYutgfAt8tjM01GMOK/1l4tAOD1vB+lWpV22GpLsNI
         fB3/YKgLJcia77ehBbANgK0c9YQAx72+nae1q6YunF/xt+3UhNTpBmMjVm7DRDjU+OeW
         eU7ojpqEs5JF0JKP2bhK5T8fKKN0uumYEAeaFYj7Sq1yVFRxPvQNdUuc/I88JCF0RRUF
         7Up+ENnmellApMPjQcx+zXBS9GYgkoZlmehOBXHE5OcwLoRXhICRX/to026tvRp9S8cd
         BTpTJiW+VZa1ijcNO6+Gr5kBIhmoxO2UA3F+U8ZZP0a0BXpgHJBlx+ZlxaY8iV7/jnD9
         R4QA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781048352; x=1781653152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VHRS+sWMPwoxZ0n+tLXpfsQUcezlTBJw4Sj0yHIKfGE=;
        b=llId6eyZ81bp1ZY/jt10+IyuAmquLUE+cohOHCGR7IWWMKhBUIAM5j/wbil419J31x
         N9Vt9XlQamTUiY8HdOwTvjp2fQvozXfMDQkLo2NjuQeyBzDe2eV7JF+f0lpEMUxYvXIR
         dhyIaWkg+W2iT+DcGlmkH9Qs5vBRo6DojcZp0f0KAmQ2m9/4Ch3EovsVzd7eWZxm7nur
         G96rqV8pmllKXxJ4aO+j9hHCWBVMVBFkaUzdelwPD9IDc6S9BDH8HVAnJx3RxnSvBa+p
         N8FeYBgV7J5BwrO5FmWtfX61A85bCe8Nx19Xc5/gfOfqJ6iwqDfQVc0cDAXOk3HpgLVM
         9ctg==
X-Forwarded-Encrypted: i=1; AFNElJ/kK891bdTebd73/OCp8ShWuy3REBcp2dgCDPFgN+eLiKfSOUDi+jAoPp9gNX8AXIb/slM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ5LUxH8wyXsDPmrzLOKxFeLe3RQDk9Dli6Kp1OhtGAyJm8g8a
	+zl+uEhtdBaaagEYNDt3nAUD7TEsuLg4ihPXm8rAjpPr1d+Ux4xzi2SBR3UalOM2QlRaLY8i7/J
	6EpsptS8ChJZIn38LqRwAruJEAMzXxYSxTQS1FDtMerl5PYSvWyk73UObyX6pQdUUqx1Hnbxr1l
	9rYyMPscr1lSVmoe/5fv89vPA9seA=
X-Gm-Gg: Acq92OF4bcMwWbhpnzW5c17w3wsUBDXgs9PPMj8UvPRv8Io2413W1BHtCPvS26T4S14
	nZlfIcr1cQSZemQu8UUcNGkF/yCpviSskmchGsK3DkMy+GehgcX7ErlZj/egkKakVr4Gc8F5wB+
	WT5J2YLNIGUp3kL8miFXS3Sgu8rwCkxk7Hi64a0o9R0WZA5ksiuRRquxvy1BW5JUSJuvqvPbQx3
	8/go+wqGQ+L1rtrNNnhP/CTh1dDYA==
X-Received: by 2002:a05:6830:6108:b0:7e5:68d0:462d with SMTP id 46e09a7af769-7e751abe2fdmr3883345a34.19.1781048352079;
        Tue, 09 Jun 2026 16:39:12 -0700 (PDT)
X-Received: by 2002:a05:6830:6108:b0:7e5:68d0:462d with SMTP id
 46e09a7af769-7e751abe2fdmr3883310a34.19.1781048351521; Tue, 09 Jun 2026
 16:39:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608185646.4085127-3-zhipingz@meta.com> <20260609195612.GA85322@bhelgaas>
In-Reply-To: <20260609195612.GA85322@bhelgaas>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Tue, 9 Jun 2026 16:38:59 -0700
X-Gm-Features: AVVi8CfvpQJ6ajVUxnazmY-1cK1d-x3MxGzuw2_lfYAMYCTtvbg2jMZaGu0O5NM
Message-ID: <CAH3zFs0u7qJ9JsfweOw_r0FqNUpixLvawZKp9pUTcWWQN6nZjw@mail.gmail.com>
Subject: Re: [PATCH v6 2/5] PCI/TPH: expose enabled requester type and
 capability helpers
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Konig <christian.koenig@amd.com>, kvm@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDIyNCBTYWx0ZWRfX4KKJbr5UxOu1
 PravrZCWzqr6z4MSGlGNg59IGL5ZF1pcRSSxoujlym9h/yWRclnu4UWlf/v2EePoF7dL+HpifRI
 hmve2JbNcJ8qaCMEyD4WKOxV2unx6e3E4P9s6mzNHBDdoMIgg+7DPaxp9rmYkuoPu7OIz+2EMbs
 wqcTNMF6H3oQ7gdt7B4cTOkZryWjLQezRjzXB6QUx+Dvd25wliSFcsPaTw8cmp/A3Dr5JcDj3vz
 jWGwRfkd5qIlbeCouTxeUKzymNSD7yfBAid78ndSX6bGViOtYIUz18JorXqh29fC/QEfG8JB9Hi
 7Vas5iFHmoO/hdSVVTz0MzGU43aQY++7+eiyR1g7jEFeMFxkvqNqutXodi7d8f4lnkykdcoGC3I
 4ZgwIJD/hUat1PRhMrLIqMytxgzY710Mz27HjezQddD1mD6tvF37qK6Iff7cD3mcm27KRWLNbDw
 oQIwmBrB82mxC8Q47dQ==
X-Proofpoint-ORIG-GUID: qzKrMLGSikI6jC-E0C_g6LsxDyT6E9h4
X-Authority-Analysis: v=2.4 cv=NOvlPU6g c=1 sm=1 tr=0 ts=6a28a420 cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=855S8uPTkML1Oy45N9_h:22
 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=1XWaLZrsAAAA:8 a=earV_t7fcAfV2sAEFq0A:9
 a=QEXdDO2ut3YA:10 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: qzKrMLGSikI6jC-E0C_g6LsxDyT6E9h4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_04,2026-06-09_02,2025-10-01_01

On Tue, Jun 9, 2026 at 12:56=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> >
> On Mon, Jun 08, 2026 at 11:56:39AM -0700, Zhiping Zhang wrote:
> > Add pcie_tph_enabled_req_type() so drivers can query the enabled TPH
> > requester mode without reaching into pci_dev internals, and
> > pcie_tph_supported() so they can test whether the device exposes the
> > PCIe TPH Extended Capability without doing the same.
>
> s/exposes/advertises/
>

ack, will fix in v7.

> > This keeps pci_dev::tph_req_type and pci_dev::tph_cap inside the
> > PCI/TPH code and provides !CONFIG_PCIE_TPH stubs for callers.
>
> Update subject line to match capitalization of history
> (use "git log --oneline drivers/pci/tph.c")
>
> s/expose/Add/ in subject.
>
> ("Expose" suggests that the interfaces already exist and we're just
> exporting them, but these interfaces didn't exist at all before.)
>

ack, thanks for pointing this out!

> > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
>
> With the above,
>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>

Thanks,
Zhiping
