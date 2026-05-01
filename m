Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E4B3E3140
	for <kvm@vger.kernel.org>; Fri,  1 May 2026 16:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777651907; cv=pass; b=WES2ZcE2ZFUtqFbfHAFOb4jOoqdzS7ecBh9GXBXQLbm4k7f0tIZvfz7CgJoXDn1vs5V46WQo8PWOqhG7SIgWCz+LxnXJVh8YETvX+k49NCxGA4kNOtbV91kJ9nEpLlaFrXG5bxvCeFpqf9xc5dChPT1BfIbSVwzPfXa7zyDobag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777651907; c=relaxed/simple;
	bh=Lg3I4a5CVSLmEfFpzSrc+IJ6RbdpOOFMUy6frdtkKdg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PtO7dFFN2p2KJavKWNkuPTEOpBZwhC+05ZwUBtVTe5+VfFCh157qh22vnXtcgYt7JTP0iXuwEgMoNqSqLZsEyLNQGd27dYd1FRgN4QOfE3WfGxA3yPZCg2vZoPR7KTGg/rnWNR4Xn5NMrBU+flSFdS5fY7oITHrOnI1DcglpEHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iuDKym33; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iuDKym33"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-12dbd0f7ecaso4643396c88.0
        for <kvm@vger.kernel.org>; Fri, 01 May 2026 09:11:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777651899; cv=none;
        d=google.com; s=arc-20240605;
        b=RgnEzNB2Yn6YK8AcPwhK/4rE67qexg6korXyxvy/K6ilcqehvDVGo2bZpYSeKcTiI/
         Un8WxLSVGMA88Job5t8EssVBWZDd3yh26Y8ExP/e58tc1YwNiaysd/sOOG7wWZ32RI2O
         aSN9EE/1g29kn8lzUjL8sot9ZIKFqMiyk5cDd2oNCziaGvSclk87D7y4NBnBvMY/UItV
         31p/JJYBRmHxnIwZrdt41Jr0vpeRWRiBiYdTVKd9FoFyDetVKKDg/OGJgD3wlLKsa6MX
         HlIOfM1XKDY5UlRQDZQtBdByeZPMRnCsTPw2w6ENTqtCVbLk4w2Xt5nA2Kj+VIJnvSH7
         UqZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qUtLnk45BiKrXHINpVcyMQeBwCn16A0KrBFa2QFTWtI=;
        fh=w0+VPqUWeU/PSZzL8vPYGvrS+erCGpPjFYLuOUEFwho=;
        b=R8G+ObiTqA5DBGXeU+q4NcXt1vx7Tkjydyv+HRuLQRlEIuC/HnwBGpOkBVmvEns76t
         KC6vkDIYBPEYUPcPEJrO6tBgb0eLk/I5BjcEZ+d+A67N+d8fQLOCPZEld3jn81wxPuMY
         Em06akdMEBPvUvd7Q36uy814+Ta8kDMcBAXiQtvKYBVWXCH/cApb6Zzavn7IBeSkQ5RR
         ac5bGJUNYOeg03EU5qWgS56KRfJTzcCQMzwsxplMIe47ADPJI3/0djPsmPk6SNK3PRt/
         PMYF63ItR3kzmQQxUKRqeaLfxUIgzJvIJOz/AShdOGg5UItsc9bp+8GAYnX3y203xGH3
         bAzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777651899; x=1778256699; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qUtLnk45BiKrXHINpVcyMQeBwCn16A0KrBFa2QFTWtI=;
        b=iuDKym332S3y8j2Dh8gx5+R6x5q9ow83jxo2eSebtwLzoL7A08OmajBfhFzWCdKifv
         tSC2/qCqb0EUCeKQDXArWwsFbvxZshdj6+YxZkOwWJCHAlm9NTkqeDbUD5DhrBf+uT8b
         7OVSxiC+3KhCsYvtennSRH1IZs6NYrEzCC0WKMmPy12hYAmghoqQEMvJSKgRc/MER5jp
         SdoEm9F7/eDVT3mm6gVwb+36REfhqT1KtcCZSynk5T8jlVrrv2iHBADepDV4W4Fny6Ce
         VqcOd4HzKiBmsbe9OdD/EaQKN8No8kqjD+EfMrTpOxVlFahLEr+8c0miMiEYERdd7FJz
         H1Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777651899; x=1778256699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qUtLnk45BiKrXHINpVcyMQeBwCn16A0KrBFa2QFTWtI=;
        b=J6S6yq/U1GPeQrGXCOqvvsWy2dJLYlPYC+iv8P4YZ11P+YxgxW81FHE3J2AoTLTkab
         me3Pf1w2ys84Ak2DiUWiprMF47DOV09Y1mEaxWa/UileJMclLkWR3cKu/OAjC0norcpz
         46KgKTaVm9ngocOJqZl0x/FtgLkiuQTb92VxBIGzN6AloJxX5PmxCudD6S/QUslufDsK
         AuI/THv28L2GS7LtXFExbmTrw2pJBrWudjk9/gZ48lI3D/KvHsNePtiAxVwjSAQpbtqf
         NmLDsP7kqPlLTve3UdehZ62ZKpJKh6X4IWMnfEyRo9fSu1aVugGhddRGAxaggCIp7sN2
         qEwQ==
X-Forwarded-Encrypted: i=1; AFNElJ+RlBAy8Z7PBbpOkShIrUorfhPcLOjffnxVgyInSONHPzSyvL4FI88czN8XH9XIkMw4Ryw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGnOhwpyS4Vf0qMNgLIyhoJqCaaJaAT4hlsjPCNtC3D4wYNOwU
	Gmve251MrwdUM9tp4+UXdkTLcFV2Wm0chhtI/DXudlLVuOeDtpRhSZC65qCI3apSELWiEChD6nz
	Lyqzgl2DqYVth/HaskfvTt2J86wIEiNxG5py8bbRy
X-Gm-Gg: AeBDievowlvSH+o6A1b7k/C+O9YKh3dJ1zjIMj7P/5tRUPUWWT2+P+L3r+8Jo+ZilRC
	pp+Btr1ct7RLN+amL/bpQUBUT1pddEwiEbfxoKugPoZ2peciH7WMmga/GcFHMTQpPm+oT2xVfFY
	y+/B0iordKxHFdwH9h6b+znwCbPtzrxJY7wICJFhWdhxWcCabpBh5h9cjkZkpiWvUmOV5YzcjMS
	nQ+dEr8UqHcekzYxWTHHTZ9nAL8gQQIgshE4muZ0HefMr1WClQHBBtRzL2UiNoJ5f+bQFC4X2q6
	S5rrU6kHqukr5QKwEFapDcQpkRAM1MFglavAtTFI
X-Received: by 2002:a05:7022:423:b0:12d:e126:b7c8 with SMTP id
 a92af1059eb24-12deac411demr3607716c88.13.1777651898369; Fri, 01 May 2026
 09:11:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
In-Reply-To: <0-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
From: David Matlack <dmatlack@google.com>
Date: Fri, 1 May 2026 09:11:11 -0700
X-Gm-Features: AVHnY4IcOZBEwRDeFauz0p7wo2ItTFGZpUDr4nDVbee6fBs6NBQ1Q0W5r-m7yp8
Message-ID: <CALzav=ci8bi3=sY+F3HJTB5sOQ_pJ8Lm+kz0CDBBWVXry5P98w@mail.gmail.com>
Subject: Re: [PATCH 00/11] mlx5 support for VFIO self test
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org, 
	Leon Romanovsky <leon@kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan <shuah@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	patches@lists.linux.dev, Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2026 at 5:08=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> Add an mlx5 driver to VFIO self test. This is largely a remix of the
> existing VFIO mlx5 driver in rdma-core. It uses an RDMA loopback QP
> to issue RDMA WRITE operations which effectively perform memory
> copies using DMA. Since mlx5 has a stable programming ABI this
> should work on devices from CX5 to current HW. The device FW must
> support the QP loopback configuration.

> This entire series was coded by Claude Code in about 4 days.

Very exciting. Josh Hilke from Google is also working on using AI to
create a selftest driver for Intel IGB NICs so VFIO selftests can run
in QEMU [1]. So it's encouraging to see you were able to do it with
mlx5.

[1] https://www.qemu.org/docs/master/system/devices/igb.html

> For those interested, the flow I used was broadly a prompt sequence
> sort of like:
>
>  - Hey Claude, go look at the falcon series, VFIO self test, the
>    mlx5 driver, rdma-core and some PDF documentation and make a
>    plan to put mlx5 under the selftest.
>  - Write an rdma-core application using the built-in VFIO provider
>    that can do the required memcpy operations that vfio selftests
>    wants.
>    (This resulted in a 1k loc C file that compiled and ran the
>     first time but had a few bugs related to device programming
>     that the AI resolved.)
>  - Replace the rdma-core components with open-coded versions to
>    create a fully stand-alone program that does the DMA memcpy.
>  - Review and audit the thing.
>  [Pause and de-slop it]
>  - Make it work on a PF too (this is surprisingly hard!).

Can it work on CX VFs? We're interested in continuously performing
memory copies across a Live Update using a VF via selftests to
demonstrate SR-IOV preservation (when we eventually get there).

>  [Move to a kernel tree and copy all the .md files and .c program
>   it made]
>  - Hey Claude, look at all this stuff and make a broad plan to
>    actually build a VFIO self test.
>  - Here is my 1 sentence advice on what each patch should look
>    like, make a detailed plan to make a patch for every one.
>  [Pause and polish the patch plans]
>  - Execute plan X then commit it [pause and de-slop each patch,
>    repeat].
>  [Review and final polish]
>
> It is based on a tree with the falcon series applied.

Thanks for sending, I look forward to reviewing!
