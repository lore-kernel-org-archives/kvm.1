Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DEA45D91A
	for <kvm@vger.kernel.org>; Tue, 15 Sep 2026 23:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789514114; cv=fail; b=uaRSHSuYQbr25W2X0PeJwvGFfxyn6stZ62enZYyeMNUw5cFyEZmmLGD6WtquRuenvptjNzouj0DaHyiae9YEmkY38ANZ1rbqSD6yEZYw73FFB43wy7nUsDHRINlsKbFmeXYYbA+db175lFqSgmwciiaHi0a/+lup3+nt34sqzk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789514114; c=relaxed/simple;
	bh=Rmo+TwHeElx+2npaJnRSKbzBj193sekBXZLZI35ZXwM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ltvz0U0DW5cxUIAmdpHtlzc8jggu6gjJnB+XjozmctNmXtk3AjnAwAUTPkH/18UTo8L5Vc8MLWPRPKzY+xb5nOb9IZeWUERB2C7etCWFvrcEL4XqutSTKUGoyM/d2AXX7GnJAyxzN9QtEgBJpq9GknBPwpIfOdbdojOQTXwKKb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=SIXx0xrA; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="SIXx0xrA"
Received: from pps.filterd (m0528006.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FMOdeh1049184
	for <kvm@vger.kernel.org>; Tue, 15 Sep 2026 16:15:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=9wSKnU6K8x6VtxP/QNuLN7MLmNw6mKZQmf+9X
	IiVvUU=; b=SIXx0xrA+TwjdlTogR7fvr6LvG2I7Icv08Az9vCa/jwMZH5282lDb
	fITP5NGPExDCwMPo2NWJYTt4cs//NI3xZM6vnLSwvCKR03RHUaKT4FRbZQXF7pW8
	wsxiplIBxZPBMsM/WO1a6MO0wTOImFGp0ZNUrmacGmQkr1i93e3ApULxS50+MCOG
	RDvPl4MJ2C+2R6YDeiugKDUPRPGote74ERplmgd5+LniAtVGTlx4x2BIu1DmUtp6
	4bCDxqPm0RNRhVOR0xeEdOywHGun5E4lFBdCvFLcju9Nq0rmk6h1Ixd6uFDthHXF
	laYCFWUso+8lYVXC18+EsNnAdYEHhqNkw==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4gqe058kxa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Tue, 15 Sep 2026 16:15:11 -0700 (PDT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7ffe94da829so2845153a34.1
        for <kvm@vger.kernel.org>; Tue, 15 Sep 2026 16:15:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789514110; cv=none;
        d=google.com; s=arc-20260327;
        b=hzP2xLZ3pKTabJdOeLMYAsb+gk2qGEKAb2nIB8DyRqVHiHf/vfxU+cAKTJbJiOFiU4
         ObrlGWW2BwOTHbdx8mPGaRB3lbQhPnppYiFbhWpVwEJ1HFWA2xyVh77EAG7tKoRfvIWU
         tQHHdbWGSQdiMYW2MNSNEEN5lSS3s78EuVD3El117tSaHAnCQ+uA7nqhBrrwYH6LbYYu
         chZR+kbtr15vd+zOTPEuusyzG/gTvbssQElR3Q0DUAUta1NU4wutjNBY1md3KFOgQzgD
         JYQQeqIcdBCDES06ilvQDFvfvuEnJTnVIIumFCn+FW9yvrEx4CoqEbPCRm1+XxxXP8Z+
         r+Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=5Z9FH4pGg+zZG5DGIDh+CM+cqcFCAu2VEGfh4kw4QyM=;
        fh=O2tTF3E03t0bDrBjQ8xdrmpPycPTcery23lWR8nAVZM=;
        b=pLyuvMbdsIjRuFCr9e6DwRGoOlyR75m45S1SbLCzu8eTnScEDVj+0BVgemzHA+fCcL
         houkRJqiM5D+YK6FksZLL8h8csrzzmsxT6vzKGnN6zsi4dLtSdB2Cg0BJQ+23lJe9q7O
         ngbBJTR7oA3Im9oNtGl3NEarYmopczsRqfWoHBUe2j7bjgk2WtBY1fMBxx2DfZ1pmVpF
         d62nQ7yO9r78zs8+hUYGeZK7aAClIqIL9kxk7wqMn+M0BhtDmT1XTmppgGdUi9uXq2jq
         k0jsBcfGuOV8o3hnUl9FfWC1CM8rF/i/mg7/cdIUbxOUHMojkGDtghKRazzRIYZbAWnW
         st0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789514110; x=1790118910;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5Z9FH4pGg+zZG5DGIDh+CM+cqcFCAu2VEGfh4kw4QyM=;
        b=V3qzrW9eP+UQf5tfb90jh130Cg8dfxLqlDudzfl1X2rfhLSHQjPMDhFSFawun1QBJW
         DMusVlK4U2sq6KGBfa0+GYbEiefG7JrWaKmw9gnYjtZ/XlDWvPL9YYH3gU8dSvZAjag5
         P6P6upUell3R9dY86ZLVdO3Wemg7JNKoM4glv4SBM03Ovhy+uspYLyg2jq2j/U+l4scQ
         DjdkC+6Ff+r/qI9d9MBfcj/nK8KY2IaFOL9WhLC9dK5x3F77NfiMDyn/BxHO8bBMW4sK
         frhbioCNuj9AcafkjByEJGhVlylaRqzz39c2mbRYFfy9aHFRlWk0qShZKcrFNK00jcI1
         4UYg==
X-Forwarded-Encrypted: i=1; AKwUvBz1CL3U6CkTQIn2KlQMLkeZpW3MwfrnOm0mA/B0Kq59+SSQ11yZfFnZHFQLHtpsYg1iI5g=@vger.kernel.org
X-Gm-Message-State: AFuF++k+3fMmwZmUqjZOo/VlKBvmhzUw8rXDLgXhmHuQMEUFmTn8NwNi
	s5fLISBGyzkRtec4uXfLJLLPL4dj1EPPXP4F3fBWxZKWh9BuQM/URgWvghNj4d6iKW+TemIh30p
	TgfNHfmmnNt8DvAbWqoQ4lhICw6fbwEi60u9sJldGPs1jzbk2ZcgNEQqyztMajEC2rtm1jPz7cm
	VfCR/xxKG2qD7o0dNcoq0ue+JaFYw=
X-Gm-Gg: AYBFou3ijw3j6m4j0IqAxg7t1MEDXLc9Dyw3CtI9Mjm7DoW7hsy2n1EkY269Uy/UFhI
	YqFDXIyD7vKBXOBn4p7ayfM8ClZ6W/0jBH5iRkbEHKDuTF3VCV/Qk1zjsZYNND03hkk43fFHd+1
	wD17gHGuoQHtMvWW1WFOx7Kn7nYgvUEgm5zO3Ednk4nrHI/V8/tRQYHdC2feTWARE5VMSU5xS1
X-Received: by 2002:a05:6830:6001:b0:7f9:555:1def with SMTP id 46e09a7af769-80b37d7fdc1mr343244a34.11.1789514110400;
        Tue, 15 Sep 2026 16:15:10 -0700 (PDT)
X-Received: by 2002:a05:6830:6001:b0:7f9:555:1def with SMTP id
 46e09a7af769-80b37d7fdc1mr343224a34.11.1789514110002; Tue, 15 Sep 2026
 16:15:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731211601.3033906-2-zhipingz@meta.com> <20260915221924.GA876929@bhelgaas>
In-Reply-To: <20260915221924.GA876929@bhelgaas>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Tue, 15 Sep 2026 16:14:58 -0700
X-Gm-Features: AcwNN1XwigNQ9uW6nBUmoxE2F8a1TK24gfEznyxrn867tS2zzsfZXU6D-kJDtU4
Message-ID: <CAH3zFs2EyhpkJXRr7gbC+Oyb3y6Y+yyVzAgXCvg7_won0er4oQ@mail.gmail.com>
Subject: Re: [PATCH v13 1/5] PCI/TPH: treat reserved 0b10 completer encoding
 as unsupported
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Michael Guralnik <michaelgur@nvidia.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Konig <christian.koenig@amd.com>,
        Alex Williamson <alex@shazbot.org>,
        Bjorn Helgaas <bhelgaas@google.com>, kvm@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Chengwen Feng <fengchengwen@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: PmA0uWCHXIl_DbH6EJQ-GPhRCccdQAXk
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDMzOSBTYWx0ZWRfX0a4qKVNouNy8
 GVjNV+j3RQnVZlT1fwBbZ0frNh62v8PwVQDP2BDGhGH24+9q9PbTqN52R6m4OLHFPOdlhjOPDgU
 7RTpP1IVrewSZrUV3NdQpX+EUktSxRM=
X-Authority-Analysis: v=2.4 cv=L/KI0OT8 c=1 sm=1 tr=0 ts=6aa9d17f cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=kkcUborcUVj0H7zxAXTl:22
 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=i0EeH86SAAAA:8 a=1XWaLZrsAAAA:8
 a=4OgE2WNpP8yww339eGMA:9 a=QEXdDO2ut3YA:10 a=eYe2g0i6gJ5uXG_o6N4q:22
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDMzOSBTYWx0ZWRfX2eSc0YvpDdEX
 iz9Th36oCIWjn7iWUvGpl0Cy79Nmprf60OkW/2tX8HFeFn/sthK0s6Pv/zel8ZSgxBb9h8hR+9m
 hJDWcwquMJ0pGt0CO2tVZvP29P6ToRExCrfrkZfMcdVZyb0WrfgVwL3H4DGzV3O1JO/PxWEVYs3
 1dYb55K4yDSWICkkNkFZqw7hhEmNpG/k8rIuGBrd1Hc3l3SaqIwPXZa7kvJMtkKOpDASLPUCLso
 k5skcXzzM3Hg18JCUtCwDDPcq+bl+aAeplQnQ++/WPEQvfn8G4FwtvxfWVEnOAHfjrif/nmSaTb
 Kd2FeI5QJiqGuWbMWGEhNXAySvTllq/XDggtrshqLtLsT3UCbEL/Hi77435/yaA8f8O0mIyLp41
 GzXeFMqyOQiNPZNZiIhUrtjtlxCMIcwxDNbD4S+dR8qax/N4iF+niyKIUvm0I8kihq6aQl/KUNI
 fqGlS1+jmgXJvYxGSIw==
X-Proofpoint-GUID: PmA0uWCHXIl_DbH6EJQ-GPhRCccdQAXk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01

On Tue, Sep 15, 2026 at 3:19=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> >
> On Fri, Jul 31, 2026 at 02:15:48PM -0700, Zhiping Zhang wrote:
> > get_rp_completer_type() returns the Root Port's "TPH Completer
> > Supported" field (bits 13:12 of Device Capabilities 2) verbatim. The
> > 0b10 encoding is reserved, but pcie_enable_tph() feeds the raw value
> > into the requester type:
> >
> >       pdev->tph_req_type =3D min(pdev->tph_req_type, rp_req_type);
> >
> > and later writes tph_req_type to the TPH Requester Enable field, which
> > only defines 0b00 (disable), 0b01 (TPH only) and 0b11 (extended TPH).
> >
> > No known hardware presents the reserved 0b10 in this field, so this is
> > defensive hardening rather than a fix for observed silicon: fold the
> > reserved encoding into "not supported" so only the three architected
> > values can ever reach the Requester Enable field.
> >
> > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> > Acked-by: Chengwen Feng <fengchengwen@huawei.com>
>
> In subject, to match history of the file:
>
>   PCI/TPH: Treat reserved 0b10 completer encoding as unsupported
>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>

Thanks Bjorn! I'll fix the subject to match the file's history and
carry your Acked-by in v14, which will otherwise just be a rebase of
v13 onto 7.3.

Thanks,
Zhiping
