Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB6B3A1D02
	for <kvm@vger.kernel.org>; Mon, 12 Oct 2026 10:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791799660; cv=pass; b=ZBoEmxxI5Yp5TJ3/ReZ7S8WAyyX1SPqCB/IYkUMJiAd4CDKVMr1T1ZCI9zNkAEUz3UDh71mgOHE1SXVGZaQFcVGnzyQ9K8uC/X1gTeQHGjF0gF6IdyQB8ku7IlF3zBq9Kk1+Hk3jeC3ZQRQ4hKhfspeSoCcoeiv2CcQoi3S/kT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791799660; c=relaxed/simple;
	bh=ngoSFJKCcMjqIKaYPLntMoiTZq1+aK2iDToLFmsMqUQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SPUnCXCYUpgkXH073H2e7BV2qyUPPZDl+wErOW+CLw+7ku1AN9yFebTNf0N92EU5MUcm55Bh+8cn8FmF3/Se4fv0R53o1M6tili1KJa7UT193X4kfPJQt7ojUpLIiHi/+rrkmQy2GOB+wEtc+AXRzFwWjwqkIRmOFd3cPCbHOtg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YqxeuCqt; arc=pass smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YqxeuCqt"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-917866225aaso28675976d6.1
        for <kvm@vger.kernel.org>; Mon, 12 Oct 2026 03:07:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791799652; cv=none;
        d=google.com; s=arc-20260327;
        b=KVx20UmR0TjVLV02khas6BkLIpGaRwasc+YoEjtixY94a82hvLLHeu7Y7Cn8p+0C8J
         JTMroJFzVFAD3YaON//vxqqEFvsZF5DQU+PmURQ3EDPabNdUKO1N6CNkiwT0QTVeETBP
         oqedwTHyZygBAqFSWRvlQKm194PGSM0on4c9HmqZ9hskRs97F/YRU/V/QX2sAW95LKdU
         uPnRbhXaav6K4lcz8mB3hwplzVZqsseOkh23pmJ/IjDMGQL3sRWdiM1ajNxuVDPuCawD
         6BffWCWjy8vjgNZW2NhboJnxZbHDxex7U5m3Sf2k9IO8IQyqopg++zg9ZI8kLTzEFUtW
         GTbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Z3gPxzFUWOWhxxZIc6/y8cCD/Xx0PXySz85Q6RMiuY4=;
        fh=7oRq3kCd4W9WvUNJKQcNvgbfDHw5Pp6Hyd9boQPkQ/M=;
        b=l+QD4YKwcvZXxXT8SQhQxc0QZQ3bjKMqSTqkvGnPa6fq6nSYU1VAyvr8OoPPZb+AJI
         WHjs/Ar5KaQYkesrdYG+uWoMWpQO+jNO+mAfjxl4UXd1zL/M7z+xAF0iWzE+ZISqieAN
         MVJGapS6I+89xNU+TTbkdOOyWpvBh56XhqMkXvGeADPzJjNI+ztNs9dKpRv8H+BtjtFN
         0sRX6yH2X2zBZFcU7RM+qpCa2NkJjcubRSgv1Dh/Gk5TKswoXX7Z6F3HcP1+O073GHl1
         Xeg1quXHskhIwQjPlcpumHYmkBRQTdO+29cGcJXX0HWHptKhfx1JiC3En8Td6Zx2+bOT
         6VVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791799652; x=1792404452; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z3gPxzFUWOWhxxZIc6/y8cCD/Xx0PXySz85Q6RMiuY4=;
        b=YqxeuCqtkxtuUJZJlw95ZalpF1RSjwb3b7ytIvMbj23gOYSs+nMc1EDzPKPzZLBScp
         jNAxh7mZ9VAxqSTuCFpTyIA0S2N1u17shw2Way01dAigJz4QEVOEuaTGdZs8ORvFE2mM
         GnX31er4fJKjo2K73S1UD7sCVCwXDj8Bo/MPlS8pfOSzsejwnmvlNzxK7WybQHO5m1/4
         IKZBU9b9yXnT0Ab9Viq1N6iCypO+rBF8TIaOjy2im3eu+QBEVTRdcB03Rg47+ZomL0C+
         1GvvCdBLunkODaLxh/IF447iPN13Ww39r88FTVxuQrvwuTHWm3VmD3COEtt+zaxKqinl
         SDAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791799652; x=1792404452;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Z3gPxzFUWOWhxxZIc6/y8cCD/Xx0PXySz85Q6RMiuY4=;
        b=SPBUuFeGeI/WWVk2QJhfBoQ6GCUpoGsgXzoguaynRrR7Pntd9Zxztj9QFTxDMVgQMW
         EPHMC1uUtj5RN/gu04fPLyb0jzU+UMlx8E7dn8ngTqOS1oS0cvZ2gwBKvW2SUi4/CY3E
         yMEvs8wK2I/Ey8DZnbGf1PgG3wcAeopFn3qUXHDbXFA83K+WxOLtBI/WvaTAQyssLGKC
         SB3nn8TRG1za6kxueddCA0ciSRISLenmU4fe0zSPHI7vyVTO+rI/rnOpQAUssReA4ODc
         V9DDGeO9nfh3VYmFPtNj46Jc1ZRE19I1KECg6fGpJBWAFC1KV6nrvD9xoIR+qrljmyjH
         nBGA==
X-Forwarded-Encrypted: i=1; AKwUvBxpL22nss5lwJOnMX64GFQ7vLXahLpaY/ZQ8rflUutlymQ0lvh6XXrUlHtKMqfVYcI07Xk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJHEMQIsJz9+aS+T8j0oLi7m+907FFXXBLGCJby/T59uIK+qgjt
	Cwooi1ll2KpoJxAo3iskbPfEp2cayOPzG9kInTqOWQTFQ8JEJq2/rHc/YubZxOyDobK/tMvDeLN
	1sFk7nZSK8j7BwXyN+i3G08YuGUcARUE=
X-Gm-Gg: AYBFou0Wgl1OufxbnaLUGa0GV6Tsh/cNDKaO1Zzy3w3aXNqlnq5hdoE1ft0GfGqXFU5
	UiTLsd3hyomsVMJLYazqIZ64xevxEWwqCgAxkAHBkEK/Z3NYBFxYlRsFgN4CJzP5P0kLGCjzcPA
	oLu/vHr8omoGjdpn4+Cc/ezN28aVsPBG00rfif89C/8vahgV1ONOIn0q+9cVDSAmzVnI2ITiOY2
	pF0CP+/RpuzZ96iGqeHJkHj/rA9B9fPndacMivtyWZqoomTb//nNfeiSeowUInk89DFFjGRbFrz
	pbqTy9PEaAlpfry9DlRISaMYNJ19jypqxOQ2WZ/D2P/j0q4dXiudmsM=
X-Received: by 2002:a05:620a:1725:b0:93e:94f2:adaa with SMTP id
 af79cd13be357-93ebd1ff9e0mr1625320185a.32.1791799651780; Mon, 12 Oct 2026
 03:07:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261011014803.100454-1-physicalmtea@gmail.com> <20261012015950-mutt-send-email-mst@kernel.org>
In-Reply-To: <20261012015950-mutt-send-email-mst@kernel.org>
From: Jia Jia <physicalmtea@gmail.com>
Date: Mon, 12 Oct 2026 18:06:54 +0800
X-Gm-Features: AclHuK81b6ciDOyZt3Ymreum_6B8T825nAgthHuFC_f3e8ltpzVIpbuECAmYi1w
Message-ID: <CAJwVaM+Lw8kJRbpMrC29QZQeoJUyfCRvic32J2huZFFTyyjekA@mail.gmail.com>
Subject: Re: [PATCH v2] vhost-scsi: do not count PI bytes in the data length
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Mike Christie <michael.christie@oracle.com>, Jason Wang <jasowangio@gmail.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Nicholas Bellinger <nab@linux-iscsi.org>, virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> On Sun, Oct 11, 2026 at 09:48:03AM +0800, Jia Jia wrote:
> > vhost_scsi_handle_vq() moves pi_bytesout or pi_bytesin into the
> > protection sgl and subtracts those bytes from exp_data_len.  The length
> > passed to TCM is still exp_data_len + prot_bytes.
> >
> > prot_bytes comes from virtio_scsi_cmd_req_pi.  With
> > VIRTIO_SCSI_F_T10_PI negotiated, vhost reads that header and does not
> > check that the CDB is a READ or WRITE.  sbc_check_prot() replaces
> > data_length from the CDB only when the protect field is non-zero.
> > target_cmd_size_check() leaves a write's data_length unchanged when the
> > CDB size is smaller, so a command that does not get that replacement
> > keeps a data_length larger than the data sgl.
> >
> > The KASAN report is a MODE SELECT whose header had pi_bytesout set.
> > The data sgl held only the parameter list.  spc_emulate_modeselect()
> > walked data_length and read the next physical page.
> >
> > Pass the data sgl length.  Protected READ and WRITE still take their
> > length from the CDB in sbc_check_prot().
> >
> > KASAN reports:
> >
> >   BUG: KASAN: use-after-free in spc_emulate_modeselect+0x145/0x380 [target_core_mod]
> >   Read of size 1
> >
> >   spc_emulate_modeselect
> >   __target_execute_cmd
> >   target_execute_cmd
> >   vhost_scsi_write_pending
> >   transport_generic_new_cmd
> >   __target_submit
> >   target_queued_submit_work
> >   process_one_work
> >   worker_thread
> >   kthread
> >   ret_from_fork
> >   ret_from_fork_asm
> >
> > Fixes: 9f977ef7b671 ("vhost-scsi: Include prot_bytes into expected data transfer length")
> > Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> > ---
> > v2:
> >   - Drop the claim that target used to subtract prot_length.
> >     9f977ef7b671 cites 14ef9200, which is not in the tree
> >   - prot_bytes comes from virtio_scsi_cmd_req_pi
>
>
> you can mention the other patches you sent fixing
> security maybe this will calm down sashiko.
>

Will do, thanks.

> >
> >  drivers/vhost/scsi.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
> > index 4f8c0260bc9e..4bd29c2ceed9 100644
> > --- a/drivers/vhost/scsi.c
> > +++ b/drivers/vhost/scsi.c
> > @@ -1534,9 +1534,13 @@ vhost_scsi_handle_vq(struct vhost_scsi *vs, struct vhost_virtqueue *vq)
> >                * vhost_scsi_queue_data_in() and vhost_scsi_queue_status()
> >                */
> >               cmd->tvc_vq_desc = vc.head;
> > +             /*
> > +              * exp_data_len is the data sgl. prot_bytes already sit in
> > +              * the protection sgl. Protected READ and WRITE replace
> > +              * data_length from the CDB in sbc_check_prot().
>
> this is barely readable - could you improve pls? even if that makes it
> a bit more verbose.
>

Thanks for the reminder. I'll improve it.

>
>
>
> > +              */
> >               vhost_scsi_target_queue_cmd(nexus, cmd, cdb, lun, task_attr,
> > -                                         data_direction,
> > -                                         exp_data_len + prot_bytes);
> > +                                         data_direction, exp_data_len);
> >               ret = 0;
> >  err:
> >               /*
> > --
> > 2.53.0
>
