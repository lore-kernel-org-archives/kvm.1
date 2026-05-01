Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD71325495
	for <kvm@vger.kernel.org>; Fri,  1 May 2026 07:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777621185; cv=pass; b=Sa9ojrBijGWTx0AL8k0L3FFyPQbnViP5Ephhd27kfYwiMAjHWr4pAc2NiRWpA2Io2kHD+4i/nvtXjtvWIvbREpwJLvGUIWIoN3zRbtMX5xNHBnj9Z+XhYWBfOqmsROFUzXSl0N8ytfFli2kMbzv+hc5py4u+H4FF3QFUAVaVivg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777621185; c=relaxed/simple;
	bh=TbLaoWYohHPqj/XG/w1dzsXdf6YqFfSZc9edl1STeRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hqDIG+/3WkunAIYGD7D57D2CHPdNw/eXF1rRe+yVxppW3ihU+SdzYYAt6aGBWBOlPfDp+TJAMjygeF//vZ+s7w77GGFTxS3ieVP7Cx+iQfZCozoon2xpXS5EgXajgl7HW4Jagmop70JNwpC12x6oGK83elCAbkP6F5/Vu9deXnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GEJ5aEQO; arc=pass smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GEJ5aEQO"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-38e7c3a2deaso16027051fa.2
        for <kvm@vger.kernel.org>; Fri, 01 May 2026 00:39:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777621182; cv=none;
        d=google.com; s=arc-20240605;
        b=EI/BNDPG0CI9LXAMs4Y+skWAeJjJey1U6XlLW3jLbYNCJ8eBBaVRfD8eT6++N7SGdU
         c3CBRiwMhP7ZX/tqvV5M3QrXg9Cd00ioyjwDLRRyy1hZQ9+ZrALte7/xpa3Kf0nOhFUG
         6wOtuBFIugzjp+LkKDlK5XF8OHhXR2v/iDy2kDBpZsSQo3DSs1++OaTsvEH58cfrCu1W
         QzRESLajiV+7Y6/3UkPh1Lze6xSLdvoOzQJjbLq2eMNYmIBrel2LM3b9FVbEfiWCJqQZ
         A3WDSNvO+8KA3XF0imnm+EMb3389x5NpUquWgThARBS7lqjBhIwjvcGnpqFoT4DAlol5
         uMQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=N5yIG/VNV+70xFszkANHVR8rh10LtJp9VdT7AZQOrpQ=;
        fh=ZDP2KRwZmAMKlsxEclPQe79EVg6Ypnpe+XA6lSM7pig=;
        b=XTeOzPUFvFFMKaTVwQmQyTqI3BqqbxY1yED1aBBxQheCVoWteDzCrXuICYkhBwhZMj
         XvcH88u8LtzdigsrtZq1Rg052N7DK8vzzR0oAefnCeZtr/dRJkhuElxuWCPampREDOF7
         DqTYKutFCaUZZPx9ABseuq/x7/ZHcgy1Yt1i5nNSunWIwF1czenlLh4j/9N0+V8XhM5e
         KAVX4S4GXAHKUezYiRUrMbeyNIXHXJ60tL3CO3lbOitJ3QgJOI5IJh92rzx9418gPKKm
         2eYOiPgYTq8dGMK7oks/Qn4ohaFrQJBlJ3D45B9oePfOGFZ/igqK5roRPnKTJzD4KRxe
         Ze8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777621182; x=1778225982; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N5yIG/VNV+70xFszkANHVR8rh10LtJp9VdT7AZQOrpQ=;
        b=GEJ5aEQOu5JLBc6QAEWPXNoNw5rmPtGCkkwJVDi/4RVZt6sP6NLm0N1Lb2skecFh1G
         L/rEjbj4kT6EpiQjScndF2ADL8GtmfTPVyJjRNj7BchFBe/LNOnOOjsFfv2sEyzNItz3
         YcSaTJAZSuRs1tR0HNPvdQsXclUK07kLBy97rFTq8tsydXZzpk4HZ3kNVo1/sXrPXk6o
         b56vqWt8Zq267NZrYGdU8K1sKJ/AS7E8XFXo0i6p0YbFri7CyTs11oATh3kcAJoWbcHj
         mfl6nOFQrX7qXQvFdUF+AjF+6AOrga66G5QTACPftbBl1PER3WU09VQUXP83j46+7eaz
         8wgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777621182; x=1778225982;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N5yIG/VNV+70xFszkANHVR8rh10LtJp9VdT7AZQOrpQ=;
        b=LB506u1v0WgP8J/fzGUfQXq5BE1/ZmlhDoBRHzgIet9USazKYa66RE4cccIkMmmAMk
         HaXxU1tBQuI/cyobw9VXvhUz3CkDGfttEa0OzVvJgB/zWs1YvVkG83Cbw78B+qJCDxAH
         yrurQ9kKlPpaaDTfZDOI7xmv+R4g7VZPgiMv86yW8SRF8uvta4d4xKEjTFyqfVqgEYys
         x3d0dyT3uyZuyCmBD8VPkuAkauhSW4bwwHeBuZzewDFGXK81nwnAcl0nLlTrzv5B1XaK
         tbaM38VfdaYP/zN7TXtR+fs8xYdGdjo+TWSAsCsL1hZhOj14BOhHpfN9nB6JB9bWBBu2
         IVXg==
X-Forwarded-Encrypted: i=1; AFNElJ+kFIJF/+p6nYCylRB7RFOhyhQcv2kqM0X8nRYre8BaCWmkRAP7cUB/rrS1nDWdisYCxog=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ2yCMNLEunF2saLVtFz+qXT9OCKq+EcXw7XHxgX8CX+73iYwP
	PYEp5fkNwV8Xomuo2CnVimexvmXajFK4BwwdQqnSy06bf+zJN/BTrODDxp49HHCRTlKJaH3OuLL
	OEKBFkAO9DXA++5dZB28QpPVPjYQZFs2qX+sCP/X6
X-Gm-Gg: AeBDiev5qAKR69HLTLOMNqx365LQWJPQlNJTJLXWDKuyw8+KI5kgNrMmxH2/j9wbbdk
	a5TaXZcfHNZgcZ1/KAo9l7vAXWgWfo7+DZOByniuwMitL/l/4Si2Ddzn9nbHi81FawojXoo5L0G
	I4OpmnwR/kNADKsNCD9g3R3ntGPwtrMBsEE2uLrEp0BFAb2tI9qvSwT7vr25eUICon6qfCdSOPr
	81UgiHN9oiiDK64e+1GKL3z0odVHCeYMUfAuU/azUHfBB7Sit47dncRl5+b6niP+3uin+P82Fpy
	5WmBrT3MK2iD/QA+/83F1/mTqVbdpiA/LQ0SMc2dRDUAUw8SeP7mKiWYUXtMAzEyrzbhESRG+0s
	/sa8xQTMcBm8dM8w3Rw==
X-Received: by 2002:a05:651c:2114:b0:38e:186e:350e with SMTP id
 38308e7fff4ca-3934dec7039mr26121991fa.7.1777621181309; Fri, 01 May 2026
 00:39:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430-kcov-refactor-common-handle-v1-1-23a0c7a0ba38@google.com>
In-Reply-To: <20260430-kcov-refactor-common-handle-v1-1-23a0c7a0ba38@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 1 May 2026 09:39:30 +0200
X-Gm-Features: AVHnY4LuOCyhbkG_hl8Sa5NNYS1SbIPwYG33VO-fKmuVe5zr0rpNYf2arYcAEvU
Message-ID: <CACT4Y+ZMJs0-9N+tcAa7Yi9-r5wshy0BAD1cdYRxBBPvOtMpZQ@mail.gmail.com>
Subject: Re: [PATCH] kcov: refactor common handle ID into kcov_common_handle_id
To: Jann Horn <jannh@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>, kasan-dev@googlegroups.com, 
	Andrew Morton <akpm@linux-foundation.org>, Alexander Potapenko <glider@google.com>, 
	Valentina Manea <valentina.manea.m@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, Hongren Zheng <i@zenithal.me>, linux-usb@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 30 Apr 2026 at 16:15, Jann Horn <jannh@google.com> wrote:
>
> Store common handle IDs in "struct kcov_common_handle_id", which consumes
> no space in non-KCOV builds.
> This cleanup removes #ifdef boilerplate code from subsystems that
> integrate with KCOV (in particular in usbip_common.h and skbuff.h, see the
> diffstat).
> This should also make it easier to add KCOV remote coverage to more
> subsystems in the future.
>
> Signed-off-by: Jann Horn <jannh@google.com>

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

Thanks!

> ---
>  drivers/usb/usbip/usbip_common.h | 29 +----------------------------
>  drivers/usb/usbip/vhci_rx.c      |  4 ++--
>  drivers/usb/usbip/vhci_sysfs.c   |  2 +-
>  drivers/vhost/vhost.h            |  2 +-
>  include/linux/kcov.h             | 12 ++++++------
>  include/linux/skbuff.h           | 14 +++-----------
>  include/linux/types.h            |  6 ++++++
>  kernel/kcov.c                    |  6 +++---
>  8 files changed, 23 insertions(+), 52 deletions(-)
>
> diff --git a/drivers/usb/usbip/usbip_common.h b/drivers/usb/usbip/usbip_common.h
> index 282efca64a01..be4c5e65a7f8 100644
> --- a/drivers/usb/usbip/usbip_common.h
> +++ b/drivers/usb/usbip/usbip_common.h
> @@ -282,9 +282,7 @@ struct usbip_device {
>                 void (*unusable)(struct usbip_device *);
>         } eh_ops;
>
> -#ifdef CONFIG_KCOV
> -       u64 kcov_handle;
> -#endif
> +       struct kcov_common_handle_id kcov_handle;
>  };
>
>  #define kthread_get_run(threadfn, data, namefmt, ...)                     \
> @@ -339,29 +337,4 @@ static inline int interface_to_devnum(struct usb_interface *interface)
>         return udev->devnum;
>  }
>
> -#ifdef CONFIG_KCOV
> -
> -static inline void usbip_kcov_handle_init(struct usbip_device *ud)
> -{
> -       ud->kcov_handle = kcov_common_handle();
> -}
> -
> -static inline void usbip_kcov_remote_start(struct usbip_device *ud)
> -{
> -       kcov_remote_start_common(ud->kcov_handle);
> -}
> -
> -static inline void usbip_kcov_remote_stop(void)
> -{
> -       kcov_remote_stop();
> -}
> -
> -#else /* CONFIG_KCOV */
> -
> -static inline void usbip_kcov_handle_init(struct usbip_device *ud) { }
> -static inline void usbip_kcov_remote_start(struct usbip_device *ud) { }
> -static inline void usbip_kcov_remote_stop(void) { }
> -
> -#endif /* CONFIG_KCOV */
> -
>  #endif /* __USBIP_COMMON_H */
> diff --git a/drivers/usb/usbip/vhci_rx.c b/drivers/usb/usbip/vhci_rx.c
> index a75f4a898a41..a678e7c89837 100644
> --- a/drivers/usb/usbip/vhci_rx.c
> +++ b/drivers/usb/usbip/vhci_rx.c
> @@ -261,9 +261,9 @@ int vhci_rx_loop(void *data)
>                 if (usbip_event_happened(ud))
>                         break;
>
> -               usbip_kcov_remote_start(ud);
> +               kcov_remote_start_common(ud->kcov_handle);
>                 vhci_rx_pdu(ud);
> -               usbip_kcov_remote_stop();
> +               kcov_remote_stop();
>         }
>
>         return 0;
> diff --git a/drivers/usb/usbip/vhci_sysfs.c b/drivers/usb/usbip/vhci_sysfs.c
> index 5bc8c47788d4..b98d14c43d13 100644
> --- a/drivers/usb/usbip/vhci_sysfs.c
> +++ b/drivers/usb/usbip/vhci_sysfs.c
> @@ -425,7 +425,7 @@ static ssize_t attach_store(struct device *dev, struct device_attribute *attr,
>         vdev->ud.tcp_rx     = tcp_rx;
>         vdev->ud.tcp_tx     = tcp_tx;
>         vdev->ud.status     = VDEV_ST_NOTASSIGNED;
> -       usbip_kcov_handle_init(&vdev->ud);
> +       vdev->ud.kcov_handle = kcov_common_handle();
>
>         spin_unlock(&vdev->ud.lock);
>         spin_unlock_irqrestore(&vhci->lock, flags);
> diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> index 4fe99765c5c7..0192ade6e749 100644
> --- a/drivers/vhost/vhost.h
> +++ b/drivers/vhost/vhost.h
> @@ -44,7 +44,7 @@ struct vhost_worker {
>         /* Used to serialize device wide flushing with worker swapping. */
>         struct mutex            mutex;
>         struct llist_head       work_list;
> -       u64                     kcov_handle;
> +       struct kcov_common_handle_id kcov_handle;
>         u32                     id;
>         int                     attachment_cnt;
>         bool                    killed;
> diff --git a/include/linux/kcov.h b/include/linux/kcov.h
> index 0143358874b0..cdb72b3859d8 100644
> --- a/include/linux/kcov.h
> +++ b/include/linux/kcov.h
> @@ -43,11 +43,11 @@ do {                                                \
>  /* See Documentation/dev-tools/kcov.rst for usage details. */
>  void kcov_remote_start(u64 handle);
>  void kcov_remote_stop(void);
> -u64 kcov_common_handle(void);
> +struct kcov_common_handle_id kcov_common_handle(void);
>
> -static inline void kcov_remote_start_common(u64 id)
> +static inline void kcov_remote_start_common(struct kcov_common_handle_id id)
>  {
> -       kcov_remote_start(kcov_remote_handle(KCOV_SUBSYSTEM_COMMON, id));
> +       kcov_remote_start(kcov_remote_handle(KCOV_SUBSYSTEM_COMMON, id.val));
>  }
>
>  static inline void kcov_remote_start_usb(u64 id)
> @@ -99,11 +99,11 @@ static inline void kcov_prepare_switch(struct task_struct *t) {}
>  static inline void kcov_finish_switch(struct task_struct *t) {}
>  static inline void kcov_remote_start(u64 handle) {}
>  static inline void kcov_remote_stop(void) {}
> -static inline u64 kcov_common_handle(void)
> +static inline struct kcov_common_handle_id kcov_common_handle(void)
>  {
> -       return 0;
> +       return (struct kcov_common_handle_id){};
>  }
> -static inline void kcov_remote_start_common(u64 id) {}
> +static inline void kcov_remote_start_common(struct kcov_common_handle_id id) {}
>  static inline void kcov_remote_start_usb(u64 id) {}
>  static inline void kcov_remote_start_usb_softirq(u64 id) {}
>  static inline void kcov_remote_stop_softirq(void) {}
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 2bcf78a4de7b..a3fe418f7ced 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -1082,9 +1082,7 @@ struct sk_buff {
>         __u16                   network_header;
>         __u16                   mac_header;
>
> -#ifdef CONFIG_KCOV
> -       u64                     kcov_handle;
> -#endif
> +       struct kcov_common_handle_id kcov_handle;
>
>         ); /* end headers group */
>
> @@ -5437,20 +5435,14 @@ static inline void skb_reset_csum_not_inet(struct sk_buff *skb)
>  }
>
>  static inline void skb_set_kcov_handle(struct sk_buff *skb,
> -                                      const u64 kcov_handle)
> +                                      struct kcov_common_handle_id kcov_handle)
>  {
> -#ifdef CONFIG_KCOV
>         skb->kcov_handle = kcov_handle;
> -#endif
>  }
>
> -static inline u64 skb_get_kcov_handle(struct sk_buff *skb)
> +static inline struct kcov_common_handle_id skb_get_kcov_handle(struct sk_buff *skb)
>  {
> -#ifdef CONFIG_KCOV
>         return skb->kcov_handle;
> -#else
> -       return 0;
> -#endif
>  }
>
>  static inline void skb_mark_for_recycle(struct sk_buff *skb)
> diff --git a/include/linux/types.h b/include/linux/types.h
> index 608050dbca6a..93166b0b0617 100644
> --- a/include/linux/types.h
> +++ b/include/linux/types.h
> @@ -224,6 +224,12 @@ struct ustat {
>         char                    f_fpack[6];
>  };
>
> +struct kcov_common_handle_id {
> +#ifdef CONFIG_KCOV
> +       u64 val;
> +#endif
> +};
> +
>  /**
>   * struct callback_head - callback structure for use with RCU and task_work
>   * @next: next update requests in a list
> diff --git a/kernel/kcov.c b/kernel/kcov.c
> index 0b369e88c7c9..a43e33a28adb 100644
> --- a/kernel/kcov.c
> +++ b/kernel/kcov.c
> @@ -1083,11 +1083,11 @@ void kcov_remote_stop(void)
>  EXPORT_SYMBOL(kcov_remote_stop);
>
>  /* See the comment before kcov_remote_start() for usage details. */
> -u64 kcov_common_handle(void)
> +struct kcov_common_handle_id kcov_common_handle(void)
>  {
>         if (!in_task())
> -               return 0;
> -       return current->kcov_handle;
> +               return (struct kcov_common_handle_id){ .val = 0 };
> +       return (struct kcov_common_handle_id){ .val = current->kcov_handle };
>  }
>  EXPORT_SYMBOL(kcov_common_handle);
>
>
> ---
> base-commit: 57b8e2d666a31fa201432d58f5fe3469a0dd83ba
> change-id: 20260430-kcov-refactor-common-handle-25178495b2eb
>
> --
> Jann Horn <jannh@google.com>
>
