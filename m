Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2182D77F5
	for <kvm@vger.kernel.org>; Fri,  9 Oct 2026 01:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791510913; cv=pass; b=unDDPY+VoMWLKElQGUnmyr2P40NSBk276zIByBkcq5h+s6CL79dqDD9GilHG8IBZua3TWtfPbXQF+UaP+l573Ef9/V6NeWgykbuk3/V26VZVwntq3I+D+C7ALJRfNoHqOJHnLjEJY8DM7pIoOLbuOrnizA19w1NfH1HThwS8CWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791510913; c=relaxed/simple;
	bh=7FfE+Gjv/oitWMZfuNkc5CF1K6v6lHM3CtNTQ6IgqBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kmhOMVbm4bxHWUnp8rTDfNRKvxGCf4MpnRKSJtW8qczyuGcDR7VsMbLfjvj52lVlqYasDVmcaoWRopeAijACjlVbRgk4THkdxOF2R038ABBno5AurycZw4TOQsWIdNya9E1W92CuP6NVcKSiPVJyADJnfaSBczGZYLh6WYzq5Fk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ek6dfgqt; arc=pass smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ek6dfgqt"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-93e635220b9so263000085a.2
        for <kvm@vger.kernel.org>; Thu, 08 Oct 2026 18:55:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791510911; cv=none;
        d=google.com; s=arc-20260327;
        b=E26WoKKRNiyFCro2ugL9exIuumrxs7PAddmJQiah4L47KqBkPNPXHXUk4fyh6Vbmmk
         6J9h+hzZsBSYbcTtAMpIHLzTr+kn7415xWneYR34C/EVcc01V9qAiCo5LYVeClTWPyrN
         LcByjLg2t6NmIsQEmzRJSqi8kMgehHwAGvzPV+XBCU7fDeMcxbyyRjnCp5MMY1bxz4Ac
         63qFiORNjVKpJvpcJqnTq2vF1CFTsz/ZBjaKTFGeqsrue/92jpoHOWQP94vQ3j+iKoS1
         I95ab+MlggBXMjM48L8i2RB8sw4hALVVUWg1xfOIDRJIuGYUHkqDaL5BXYfPfBwETe+V
         km+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=irH5WtAUt7osstUCIXJbKMQBkmRxwYnXlK49ZN1iZhw=;
        fh=UKAVRDMurhtTZ+F4vbuN13aVcrPQ0fBIorXRUmeejGU=;
        b=Lk0EupA0glTN7DceaMFDe1/wkSJzv+MWX8kPpuvyfobrFZZetmucM/PpYCxiNYleWd
         RBkbuei7kgo1BjKIgvM6fNVLS5aZ+TzbuAVLJy++GBDk18CbturFqYZDJa5VkGxc+yio
         /7RFh96dkRxwsE2TZwp5DHya4Ysa000nI059vrFlxRVYuzODYVYFLBbPvLxj5autmEi6
         5rwVbmKJScukTwFogBMiAQ1iv4wd1Or3ubz88U7AqX9DDbqfKUPi32/LNoTE3XNC0Kjo
         IFJSNvLAQIhTyRDSRAvNpeDxIOK1f/D8onEOhsE6fsvPi0tgYuXLSKULn+me+95JNhqg
         j0fw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791510911; x=1792115711; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=irH5WtAUt7osstUCIXJbKMQBkmRxwYnXlK49ZN1iZhw=;
        b=Ek6dfgqtJGMFnOaaZI2ajABVdnx7qHW+nRCj/Ny8PxOnr/xBdhlk1ccFKfpCSKZk3i
         rU9sWRuxANy3nJJVRb1KX/2Z/+RIlTptDvA1dzkHQZ7G8A2Yj6O6RkAzusiCOsPamDjk
         3o90/N8gnoKFC6GsvulJwo7wQiQJWCkylqIZ1XIN4humBur0tCBY9hHlV1cX5i0qSIb7
         4MSITv5Bh4HczFSj/z4P4n4AjWhofNoXw+8lBceQbMC0tTkz1t8LgG+HfzZCFHb3KMSn
         2YtUYuYtP72hr2Bajyg9h2fclsmYR3fJxy9lYfF/L0PgHPtqkss4bD9oUG3+hLwIjMh4
         VlCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791510911; x=1792115711;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=irH5WtAUt7osstUCIXJbKMQBkmRxwYnXlK49ZN1iZhw=;
        b=pZmb9x6rBO+aNjFmBU9Tk15+tO8pFOuVGHuAibZ0EHhxU0iayEF8fQMzeABqfRCO7G
         5mihoEM0SIRylFJTnmXeQaXClvXl6MgIjjNox71Oaf9Lsale6OD/o7/291wGIW21LOAm
         V6k/JQYMth6PSD3db5XhZ1YukiJR3EgDVspqlV4qczV2+O1mZrTZzFwMgQpa6A7APC5T
         IVETC1FL/N74CSxRgHB3FOdg26Ts67cS3DpPVIXLneFjv56prroEnudP048G7YcRag3W
         MPQWMlYlUdCSH3TbWuQEJ5VYEYwfaFXA5gpEvLNbVHwP6or0DSYRDkUdMBVlF6q7y6rx
         XFjQ==
X-Forwarded-Encrypted: i=1; AKwUvBykPWog5mqzjJX6ClveErR1t0pOVtjmf+DRG8iHF6Og0ER9SmbkCUR7yaBZkgnhHbMoRPE=@vger.kernel.org
X-Gm-Message-State: AFuF++lwvCDA+YJZfYJH+4F1YhQjXQkuSUJAm0tfjeeVGJDOQXolfzbC
	XCA8RqLrpgzZqcP+IITvrylUgJVi9Atjz0UW/tbBpy5ujhapp9FE2fx/UET7Z53BAtgsVVe3msr
	+bZFcy1YmxRslPUUEZaVkenzbTRdpN8xXjOr2
X-Gm-Gg: AYBFou149IP5nx63h1keLYVAa1qLonD2TqYVePlcvU0RDP4h1Aa1e74HXoBLiqPpG/a
	kP/BWMB5vylTmW26VwP9wAB9qJGkmI2LzvwDsepqCBvMJhHLlU9X/JyTV1m8MyEOIpPQHAYeoO+
	m/ERGCumcs9EL7d3nTlo1z4xW6CqGpPZ9Yuhj+Te3aSzVICE7dTp3+xNQpmdL8j18AkFw1gdBae
	pm8Oo0R1HX3A0tHUAEpNzlg/vRqm5GLp+QbwO1TfoZKP+0OwLrC5z+qn0ZrbwRemqbv+4zHNX4G
	iR1RN/iB/32NRuN40DFl8gFBWLUDb7qoyA/m2RI8GaaY7zTJJzZStZg=
X-Received: by 2002:a05:620a:4146:b0:93b:d79e:18ff with SMTP id
 af79cd13be357-93ebd4b3751mr66750985a.66.1791510910201; Thu, 08 Oct 2026
 18:55:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261006082102.27085-1-physicalmtea@gmail.com> <08e68e3e-172e-4349-825e-13bafda8c365@oracle.com>
In-Reply-To: <08e68e3e-172e-4349-825e-13bafda8c365@oracle.com>
From: Jia Jia <physicalmtea@gmail.com>
Date: Fri, 9 Oct 2026 09:54:33 +0800
X-Gm-Features: AclHuK_8ZpspQbr1VUz--jCkNxAVH4PyEVkIwHKuXxRYnqVazc-zqTuVcZPApWY
Message-ID: <CAJwVaMJCgJYJP3Mr5V69cxFe9mNGmG+SNAeP6Bv9+cYc0vnr=Q@mail.gmail.com>
Subject: Re: [PATCH] vhost-scsi: do not count PI bytes in the data length
To: Mike Christie <michael.christie@oracle.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> On 10/6/26 3:21 AM, Jia Jia wrote:
> > vhost_scsi_handle_vq() moves pi_bytesout and pi_bytesin into the
> > protection sgl and subtracts them from exp_data_len.  The length passed
> > to TCM is still exp_data_len + prot_bytes.
> >
> > That sum matched an older target path which subtracted prot_length
> > again.  sbc_check_prot() now replaces data_length from the CDB only
>
> What patch changed this? Did all the drivers except vhost-scsi get fixed?
>

I had that wrong.  9f977ef7b671 says target would subtract prot_length
and points at 14ef9200.  That commit is not in the tree, and the target
code never subtracts prot_length.  The in-tree behavior is
e2a4f55c6498: if protect is non-zero, sbc_check_prot() sets
data_length from the CDB.  The vhost add has been there since
9f977ef7b671, in the same pull.  Nothing later changed it.

> > when the protect field is non-zero, and only for READ and WRITE.
> > target_cmd_size_check() leaves a write's data_length unchanged when the
> > CDB size is smaller.
> >
> > MODE SELECT, SET TARGET PORT GROUPS and UNMAP then use data_length as
> > the size of t_data_sg.  The PI bytes are not in that sgl.  A parameter
>
> Can you have prot_bytes > 0 with those commands?

I did not describe this clearly.  MODE SELECT is not where prot_bytes
comes from.
With VIRTIO_SCSI_F_T10_PI negotiated, pi_bytesout can be set in
virtio_scsi_cmd_req_pi, and vhost does not check that the CDB is a
READ or WRITE. .
A MODE SELECT sent with that field set hits this.  That is what I ran.
