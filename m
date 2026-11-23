Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795411393;
	b=JK+/xnJksmwPb0NYi1hWhN5ekegDeTk3Y5stgUrfC0ySX33RXjRoffXXQiel96Y7H5sC
	 ps/M/RZQcMFV6j/h3xCbJKBViNG6HktfY6aX0mmD50YlEyLul42Cw9HZLU/ox5uCkQMlR
	 rBD0kqNu3uSfU03fExiFmR+LXExffW3Z/Y13Qern711sGlOpiSVMLMJyg8EuEtVsfPaYF
	 adl5dr4Hl7o1mlJQxehabhiPE4nKVrSlgagDTuAhVzZPihkUALeqvNb5elxRYGMwjb6Ks
	 BBwbxnfpnXntVhbWSi5klyqgmxNMSPVsXkZjxVnXkIYihZDLrmDyQoOpMlGQ3lE93xQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795411393;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=zj1KMJVaKNaumg9rUcx+XITIlfu/2H9J2RhD6HuzcNQ=;
	b=VjXTrZzG2DTruqm46vsmBVJiarbzVeMtoCb8pQf1B4v8CdRkEl0lt8+8t4WCVcNKRA6Y
	 pQoLT5fgN2ipc0KIXhXY1G2tGmGRvkGqEr9K6RO27QHS34xKHT2iQnSKAE0mUUmcEKeHb
	 QqziS7KRB+812hBF6U/g/uSoff3yTbRjN4iV+FdHWeUKWQxcrQcs3rzMW+ZPe0lujjIb/
	 RAoj//i/ekzyh6lQ2gWviCumeIMM3NiGwNyfJ/R0iofAFr+guKHIZwW17nuYnRGqry7Gl
	 ksYIWeR/eGNHzmwJ5y1F09/hDFHXq5rxLiwOEbB4qHCFiFRAoHPLIUj+ekiVz6nm1fA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Mwj+h2QP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.176
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE91D606A31F
	for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 05:23:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE91D606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Mwj+h2QP
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3ad0102edd4so26313251fa.1
        for <kvm@vger.kernel.org>; Sun, 22 Nov 2026 21:23:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795411391; cv=none;
        d=google.com; s=arc-20260327;
        b=CncPIU3pQAzskjh/MqeU+nhZgppcmBh3ARM3poLICaWcrHQ8j1xyLKTR+IC0iSJt13
         6k2n13mngCQvFuhfRx15wEUQpUTONwLqkC6SsqYhFlZkmFUEyeDj6tOrgu4yCdZhXvTG
         Kx+DgBJU50wS4BpmT/EPtSbMwGLACHav8sSW+YsBg8CV5aPBBZXwhr9XdeDXdlzjKRHV
         Nk56K3f4N+yK7UuiTWmRtBFz0KfJheE3pDCbM/smHXmZc75sCt05p+cOaNaIW7TexIQR
         xrfnO488Fddk5ntP711T1rVTKWXlKrZVnuHETQuV1xd/QyW0AWpqzXXPn9el/SBPnUgD
         rdnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=zj1KMJVaKNaumg9rUcx+XITIlfu/2H9J2RhD6HuzcNQ=;
        fh=fqC6OhhIRkENjfrYs4jDKa+YlcuRRmzt+ZEj9aXUBeg=;
        b=aPrLcI6KiC5wFa9lCGcderBK02N6RN1z8E0D4ADS2CmIu+E9MlBPcMl8zV4cjy3/9g
         jVV8kj1OWtS4oVXz5+ISCy6k1O5freEa1o5CPOO857bw9wnMllxXVTPSswKdNMegmxk6
         LNQgjnmddXopyk1b1CSyqeut9NbDV7s+qWh8Ui0ICKn2q0HTzFM6xrNXzg9uJVgRyz8N
         QHq75oD2lgjcsXvXd7g1zYZq3SOM/H+Ayqnz8QA8iG/lQ7vLv4M6MzsrZqh1myPhzarL
         OzWxxhDLL9HxArdaSf119PcMwY7/IoTRyG0uGNsyaN1MnKHezpqGtudyLaPOWvMtOE6b
         zIhA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795411391; x=1796016191; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zj1KMJVaKNaumg9rUcx+XITIlfu/2H9J2RhD6HuzcNQ=;
        b=Mwj+h2QPeqw6v8be7H58zceYRBdzZKvfvq6oyrHUkdqisW9TaJtZ0tgOg8vu8BUm+U
         UGIgY+DOf/aBCpAuS7FdqHskAk5H7OoxMjs0C09FknECuTQpq94Vd5xm2Ym1rmF7rCbn
         GNCHoF1hhDNLi4QT8By+TMCzderkFrpAUFR0LoI6wO8XBa7XsXwnhZ0zp7y/qUmu8GWN
         6fMXid99IZUF7kVzgl7PkDVjCS0IDGbU+kdw/mwgLopOuFk1nIpQPLh4b0LOPHcZVJXC
         VqObrIJYOOnc4980Dbz+DGtQ6h0LLXjARtrDzNddjPsUfP59MXLzpLp9r3SpjWB8jvPC
         plpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795411391; x=1796016191;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zj1KMJVaKNaumg9rUcx+XITIlfu/2H9J2RhD6HuzcNQ=;
        b=OEGlMgmfzvUynLmfA+YplDnNwag3QdEU96M1SHJQJHPk9KTiVH/PZh/bP7UJHFeaDH
         E5DzaPnI5DdcQxoIZnUOHMJqulg7yDuIa6geooR7cnKhdMgR/IvOOCqN4AmzZPQUhzpK
         BfpQCqvNFF4k3oUeZK+WY+kOzIyTJdiLSsVGZ7Yb1GfvgoLjCe3pRjO/G2ie8+e1E0Hy
         AlFcirA2o6oGgBO3637uPBODe+9vJm+EIWNhQro9i2yNgaTeEZCK3c90M9KjypPTTqJx
         icpfgwX/k9nqtlxnkhYP5zAPSbse970+Egy3cFtVMtgsG0b1X8iKALAQCNE2mbggOTpi
         WFog==
X-Forwarded-Encrypted: i=1; AL+hErH7DTq+uRD2nmwxxQLLM8yISGiD58SwBFsZMZPfBjBWRwMt3tV5jEpRHYCjucLBxEA7xO8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8x/hK5DiDnTokhZuswJgfFDD11YBdZVgeRRhgBYRFe52SPjYI3
	YuUmKrxxWCdMFYnaGHGIBvyDCuDHmt2OGIoKU/NaVSyVeTvjCqXFhfTKtYXXuJhvu4cyY4fNybU
	DNIFbEbJ0vC1Ekso8zgJkcT51AoMh5T8=
X-Gm-Gg: AZFdTZdh9iMS5hjOM7nSYfJxalFwIv7GvjQrXc2xsS9/gxxol4N+Cu/dF4UHmDUmaKS
	DPVYdUd2PBNAwufdQ3OCUOpX1gshEq3z8Sc5sJpNOc8YhHOvFBhUovhZcRn3yxQitWK59xIEzns
	cpHBxgLMSK5j1lA4GBu2duBy0XLCdrtoux2HnyeeJxWng754uOJOPYlMqIT7FkjJVrkhNr3FAHy
	YGyzITRIdBTlpF5xWoSE+MmLXij1A+vK1W0TSlcapAH8yZ/VAFjHWVjpKZzsOPNK1wyLVIlcKLK
	K/1Fw67yYif9oJw5HpPLFadEPGAifpTOZUGwuQlcYm/CcIsXD5+79V5ioPrYpBHO7qyoE2zb+e8
	0RmVcVpcGILLe4HyIeKaljMN/y1MMZ+gvR9JclgtKLuDPW1RoIXVPLgnDz14=
X-Received: by 2002:a05:651c:4186:b0:3ac:efb1:6def with SMTP id
 38308e7fff4ca-3ae7f9f7df0mr23250971fa.12.1795411390729; Sun, 22 Nov 2026
 21:23:10 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106054811.281798-2-oss.patchbox@gmail.com> <add2bfe5-0d8a-4b64-a8dd-5e02be00e425@oracle.com>
In-Reply-To: <add2bfe5-0d8a-4b64-a8dd-5e02be00e425@oracle.com>
From: Yuho Choi <oss.patchbox@gmail.com>
Date: Mon, 23 Nov 2026 00:22:57 -0500
X-Gm-Features: Aa3M54o18bPzB_y6cN5ZyBXSDft40ObSb8CAiNsU_ZagFcTkH4vNqu9TTbhSp9U
Message-ID: <CAGG=RgDLSueREjeeyw09oo8ttLHN2VYUC0qEDv+HYFUrSo0LdA@mail.gmail.com>
Subject: Re: [PATCH v1] vhost-scsi: do not validate vrings during endpoint teardown
To: Mike Christie <michael.christie@oracle.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thanks for the review!

On Sun, 8 Nov 2026 at 14:05, Mike Christie <michael.christie@oracle.com> wrote:
>
> Can you describe the bug a little more?
>
> If we have done vhost_scsi_set_endpoint successfully, are you saying a later
> call to vhost_scsi_clear_endpoint could fail the. vhost_vq_access_ok check
> and not teardown the endpoint?

Yes, the first case is what I meant. Sorry for not explaining the
failure path in the commit message.

Since a543346b96a1 ("vhost-scsi: reject delayed virtqueue setup"), I/O
virtqueues that are not configured when SET_ENDPOINT is called remain
without a backend.

VHOST_SET_LOG_BASE validates the new log base only for virtqueues with
a backend. Therefore, an invalid log base can be stored in an inactive
virtqueue even when the ioctl returns -EFAULT. A subsequent
CLEAR_ENDPOINT then fails vhost_vq_access_ok() and skips teardown.

I reproduced this on current mainline (8dac6df92a2e) with KASAN, with
the following sequence:

  VHOST_SET_OWNER
  VHOST_SET_FEATURES(VHOST_F_LOG_ALL)
  VHOST_SET_MEM_TABLE
  Set up vq 0, 1, and 2 only
  VHOST_SCSI_SET_ENDPOINT             -> 0
  VHOST_SET_LOG_BASE(kernel address)  -> -EFAULT
  VHOST_SCSI_CLEAR_ENDPOINT           -> -EFAULT
  close()

After close(), tpg->vhost_scsi still points to the freed vs. Linking
another LUN triggers a KASAN use-after-free in vhost_scsi_do_plug().

I also reproduced the in-flight command UAF described in the commit
message. A delayed READ completion after close() triggers KASAN in
vhost_scsi_release_cmd(). The READ has to be queued after the
VHOST_SET_LOG_BASE call, because device ioctls flush in-flight
commands.

With the patch applied, both reproductions complete without KASAN
reports, and endpoint teardown succeeds.

Without a successful SET_ENDPOINT, no command can start, so the second
scenario you mentioned is not what I meant.

I can share the reproducer and full KASAN reports if useful. I'll
include the failure sequence in v2.

Thanks
