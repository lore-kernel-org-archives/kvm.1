Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27DB3644A2
	for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 17:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774977801; cv=pass; b=OVYelvJxQLnC2EjTUfFxc8N+onfbQOlpUMnRYXTvIiDFvF6ewjMXjULD/gaB3hThnBtuhLMiY/4lZ7G9w6BV7buXPAvGdTeie/EdhKIWa/ku7W6D658wbSpPlk9he0vNKLiUg6cBafCvoMR/Qn2xAyZ2nZxbhE2d2BxK7PfRs28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774977801; c=relaxed/simple;
	bh=4O8B+ssQ4Pb5V7qee9AVzd4LQ8TvBPiwQPihEYeTN3A=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=JEuIC2W+Nw8SQjZW0hA/B6rZdl5e9SZvS9x5YfIdwFxEMFs0PlU8DvM9qhPG+8Tscoq9uTNfHS1eHmC+yK0vbD/AQIP8dnOgTYyMZwYfUXDDVEclYq+msL/nsGNhSty8Y43k88GHZ6FHhCgHq0+lMH0B4rIeoKO7Y7AlK6IcqEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eeK3AIIQ; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eeK3AIIQ"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-509062d829dso647681cf.1
        for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 10:23:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774977799; cv=none;
        d=google.com; s=arc-20240605;
        b=ECXp/ec3/MCVpzVKXXR9DDMifTOt16gUjMnFBdDRYnuh3vX8Bgm7oGhFcYoIz4HQoX
         AccLWR8sgwl6rAmU6KGScDO4fMZnQk1W+iYSA9TtxJGQrj3Lj8kb9EV0StEcvuOj9kZk
         Z2DLuqj97Ht2qeVAGhnyW12GEyYwJwGC4u5JFA1+u21QVrVVqd6VjnkxTY1NqaJMuB3p
         IypvB5qSO7La1cvx8x4qi+6DJ3wNifNG/INbW/8K0TQ0O/7jaVkHOyKUtvCj67NiR3ar
         1ttD15Gj607Yb5rgt5LKXrJOoQkHyAEt1zWViXmhQx3RG9ltKlbTkdgWc8bSgKZnOBpi
         kUnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=xfWyR5Bt/s3UxGGXxRm5lQuzzRDmpPpu5B45UFWlrgw=;
        fh=xutXh6t7q6zBn0D3J6yTjyII/H/L4pqb7JUOspu6D3M=;
        b=X3s81CugsYVrSDlB2FqvliIB285MSP8J4690TzCqWDvMGQMJHEIAAD1zaxZMMw/YTU
         NAeXvDaiQe1AP9Doypy9lxAZYuz21cYerL5+szElV08Zao+xhqp/bZmg5SZpQnc4ihhv
         OnIkPXejmxDJFZedT8attSBqo0MkLfKFmbFqa0v2BydfK4DitI321AXXRoqL9wq4Ybrj
         0BW+BifiMTvTbCTyEsYXwnb+lIQliOePIM4T3qClAcLm7urVZXYlxDWEpe41zklkQxwj
         Q+He42P2AbqURnTqXSvtwbyBp3Ww+TqiVhxb7s6hYDVXuoF4ZV9SFYMyqf4G50LMXYxf
         +iOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774977799; x=1775582599; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xfWyR5Bt/s3UxGGXxRm5lQuzzRDmpPpu5B45UFWlrgw=;
        b=eeK3AIIQctth5woJ6Y4FFocEYOhJ1I/U5sA6IEO/DcP8PdQLn9kuCR8skI8oIK1+s4
         dsgc7V+52ctM4V9dRP8YIvSIqLBcR8b4QLgZ4hdXM3ASqh2rB74/cahLnE+gnXCLh7pA
         DWMk1VFNifLQ8/DpARPJPOrU2OMf54YmZBf3RClT6E899LXIVabC34SVJSGiibX72wOb
         D9NBJrkUVLFRX+QiX8B/agFMFsHf/qI//yQaRXAUvdOvtlB19mccOMJUuXEAjVtp4SiA
         Hh0wimtrmrBXR/kA42++64rs2Qnx+w3fyoyKumm1ji3AqbpCDjY4L2qAHJltzpqB6nMa
         KaVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774977799; x=1775582599;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xfWyR5Bt/s3UxGGXxRm5lQuzzRDmpPpu5B45UFWlrgw=;
        b=NPga2VEWZe5WOOki5qJegtx8KnFUxfJWhOiZBl+cvXMCzwm8Hc00CWhmtvXcgI+oqK
         EWU2hv49KTzy/jQdw0viq9LIsKWhM33ilBsa0dWNW2UURsbjiNM9AsAy3tbpOM2qMyIk
         tHWvqdjqT2DhQjhy/IOOTrOXB4jqPGbc+X7nf/VUP2k3RgAjsXQj0pktwSKhooK1hRTk
         gC+aMmZ6Kqi/cnNFSy6U+jh2Y2g2U8hvWIISTa0Ip6jNdJ0X7Ggdqx/CJg1K+sXam8su
         G0RYvap2V/RXIOS93PjpsuvrT02AMYMnTc0cYFlUTueoeGnLXjmwHkMBDyNSpgoEVqYQ
         1ZBA==
X-Forwarded-Encrypted: i=1; AJvYcCXXzLQpActs9MOB6N32/fi/yKYksyszoczA6iHvZ+neETZAezbVjrGYwQgmmMWZnswpU1M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx159r33bwHHw3V6mElndLoeJbseDjywKKI0GNcZv9ZCm6lXorZ
	QIKVylA6N/CpVSuDbF1dG6n3Pd3ccHi6I4wfLUTIoVz8uJBDlEbd7dRGu96HQHuE2/Uq7l6noHM
	MMhhGy7mTu3hSpPzuYvIv6NiW3IIKGwK2Qva4gzvE
X-Gm-Gg: ATEYQzx/Rc8ouets6Vr5UpBeYrfqlJ0N/JGoryFAbzzUD/T5ccI8XGv+2et+fqvsSdm
	Ob+PdWQEExFNYaI9niUZXqK69qh/aQmSaQ2Weg5G+tFRAVmHMWclg9ifzlyMNPegSKlKah91kzp
	RA9GbqMgiYlC3WemzbP/4oC8SyjO9CNaotOY0OeIgFuCjpcRewF5HdLFsdX64xVzMafiL4XJ2Sb
	N3a/LP6nUyWx9tCDZBwxGqk3f45dNymTUXfjIKBsz40jnzmQ1jVbJZPD4iB5IZrARQq7spo8yYn
	BhDRH3tp
X-Received: by 2002:ac8:7e8a:0:b0:509:cd7:aa18 with SMTP id
 d75a77b69052e-50d3b84b356mr2139331cf.10.1774977797806; Tue, 31 Mar 2026
 10:23:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Raghavendra Rao Ananta <rananta@google.com>
Date: Tue, 31 Mar 2026 10:23:06 -0700
X-Gm-Features: AQROBzAug7VW6B-qzD1poV9KLyWd12C1M343Pk2V-DjifVSozVj00eJJb1i-ZW0
Message-ID: <CAJHc60zTBn9xMksi-_UBK=W07rp2vGVZ9ToYhFyadNz4zCVHAA@mail.gmail.com>
Subject: [RFC] Observed lockdep circular dependency in SR-IOV paths
To: Alex Williamson <alex@shazbot.org>
Cc: David Matlack <dmatlack@google.com>, Vipin Sharma <vipinsh@google.com>, 
	Josh Hilke <jrhilke@google.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Alex,

While running the vfio_pci_sriov_uapi_test [1] on a CONFIG_LOCKDEP
enabled kernel (7.0-rc1), we observed the following lockdep circular
locking dependency warning:

[  286.997167] ======================================================
[  287.003363] WARNING: possible circular locking dependency detected
[  287.009562] 7.0.0-dbg-DEV #3 Tainted: G S
[  287.015074] ------------------------------------------------------
[  287.021270] vfio_pci_sriov_/18636 is trying to acquire lock:
[  287.026942] ff45bea2294d4968 (&vdev->memory_lock){+.+.}-{4:4}, at:
vfio_pci_core_runtime_resume+0x1f/0xa0
[  287.036530]
[  287.036530] but task is already holding lock:
[  287.042383] ff45bea3a96b8230 (&new_dev_set->lock){+.+.}-{4:4}, at:
vfio_group_fops_unl_ioctl+0x44d/0x7b0
[  287.051879]
[  287.051879] which lock already depends on the new lock.
[  287.051879]
[  287.060070]
[  287.060070] the existing dependency chain (in reverse order) is:
[  287.067568]
[  287.067568] -> #2 (&new_dev_set->lock){+.+.}-{4:4}:
[  287.073941]        __mutex_lock+0x92/0xb80
[  287.078058]        vfio_assign_device_set+0x66/0x1b0
[  287.083042]        vfio_pci_core_register_device+0xd1/0x2a0
[  287.088638]        vfio_pci_probe+0xd2/0x100
[  287.092933]        local_pci_probe_callback+0x4d/0xa0
[  287.098001]        process_scheduled_works+0x2ca/0x680
[  287.103158]        worker_thread+0x1e8/0x2f0
[  287.107452]        kthread+0x10c/0x140
[  287.111230]        ret_from_fork+0x18e/0x360
[  287.115519]        ret_from_fork_asm+0x1a/0x30
[  287.119983]
[  287.119983] -> #1 ((work_completion)(&arg.work)){+.+.}-{0:0}:
[  287.127219]        __flush_work+0x345/0x490
[  287.131429]        pci_device_probe+0x2e3/0x490
[  287.135979]        really_probe+0x1f9/0x4e0
[  287.140180]        __driver_probe_device+0x77/0x100
[  287.145079]        driver_probe_device+0x1e/0x110
[  287.149803]        __device_attach_driver+0xe3/0x170
[  287.154789]        bus_for_each_drv+0x125/0x150
[  287.159346]        __device_attach+0xca/0x1a0
[  287.163720]        device_initial_probe+0x34/0x50
[  287.168445]        pci_bus_add_device+0x6e/0x90
[  287.172995]        pci_iov_add_virtfn+0x3c9/0x3e0
[  287.177719]        sriov_add_vfs+0x2c/0x60
[  287.181838]        sriov_enable+0x306/0x4a0
[  287.186038]        vfio_pci_core_sriov_configure+0x184/0x220
[  287.191715]        sriov_numvfs_store+0xd9/0x1c0
[  287.196351]        kernfs_fop_write_iter+0x13f/0x1d0
[  287.201338]        vfs_write+0x2be/0x3b0
[  287.205286]        ksys_write+0x73/0x100
[  287.209233]        do_syscall_64+0x14d/0x750
[  287.213529]        entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  287.219120]
[  287.219120] -> #0 (&vdev->memory_lock){+.+.}-{4:4}:
[  287.225491]        __lock_acquire+0x14c6/0x2800
[  287.230048]        lock_acquire+0xd3/0x2f0
[  287.234168]        down_write+0x3a/0xc0
[  287.238019]        vfio_pci_core_runtime_resume+0x1f/0xa0
[  287.243436]        __rpm_callback+0x8c/0x310
[  287.247730]        rpm_resume+0x529/0x6f0
[  287.251765]        __pm_runtime_resume+0x68/0x90
[  287.256402]        vfio_pci_core_enable+0x44/0x310
[  287.261216]        vfio_pci_open_device+0x1c/0x80
[  287.265947]        vfio_df_open+0x10f/0x150
[  287.270148]        vfio_group_fops_unl_ioctl+0x4a4/0x7b0
[  287.275476]        __se_sys_ioctl+0x71/0xc0
[  287.279679]        do_syscall_64+0x14d/0x750
[  287.283975]        entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  287.289559]
[  287.289559] other info that might help us debug this:
[  287.289559]
[  287.297582] Chain exists of:
[  287.297582]   &vdev->memory_lock --> (work_completion)(&arg.work)
--> &new_dev_set->lock
[  287.297582]
[  287.310023]  Possible unsafe locking scenario:
[  287.310023]
[  287.315961]        CPU0                    CPU1
[  287.320510]        ----                    ----
[  287.325059]   lock(&new_dev_set->lock);
[  287.328917]
lock((work_completion)(&arg.work));
[  287.336153]                                lock(&new_dev_set->lock);
[  287.342523]   lock(&vdev->memory_lock);
[  287.346382]
[  287.346382]  *** DEADLOCK ***
[  287.346382]
[  287.352315] 2 locks held by vfio_pci_sriov_/18636:
[  287.357125]  #0: ff45bea208ed3e18 (&group->group_lock){+.+.}-{4:4},
at: vfio_group_fops_unl_ioctl+0x3e3/0x7b0
[  287.367048]  #1: ff45bea3a96b8230 (&new_dev_set->lock){+.+.}-{4:4},
at: vfio_group_fops_unl_ioctl+0x44d/0x7b0
[  287.376976]
[  287.376976] stack backtrace:
[  287.381353] CPU: 191 UID: 0 PID: 18636 Comm: vfio_pci_sriov_
Tainted: G S                  7.0.0-dbg-DEV #3 PREEMPTLAZY
[  287.381355] Tainted: [S]=CPU_OUT_OF_SPEC
[  287.381356] Call Trace:
[  287.381357]  <TASK>
[  287.381358]  dump_stack_lvl+0x54/0x70
[  287.381361]  print_circular_bug+0x2e1/0x300
[  287.381363]  check_noncircular+0xf9/0x120
[  287.381364]  ? __lock_acquire+0x5b4/0x2800
[  287.381366]  __lock_acquire+0x14c6/0x2800
[  287.381368]  ? pci_mmcfg_read+0x4f/0x220
[  287.381370]  ? pci_mmcfg_write+0x57/0x220
[  287.381371]  ? lock_acquire+0xd3/0x2f0
[  287.381373]  ? pci_mmcfg_write+0x57/0x220
[  287.381374]  ? lock_release+0xef/0x360
[  287.381376]  ? vfio_pci_core_runtime_resume+0x1f/0xa0
[  287.381377]  lock_acquire+0xd3/0x2f0
[  287.381378]  ? vfio_pci_core_runtime_resume+0x1f/0xa0
[  287.381379]  ? lock_is_held_type+0x76/0x100
[  287.381382]  down_write+0x3a/0xc0
[  287.381382]  ? vfio_pci_core_runtime_resume+0x1f/0xa0
[  287.381383]  vfio_pci_core_runtime_resume+0x1f/0xa0
[  287.381384]  ? __pfx_pci_pm_runtime_resume+0x10/0x10
[  287.381385]  __rpm_callback+0x8c/0x310
[  287.381386]  ? ktime_get_mono_fast_ns+0x3d/0xb0
[  287.381389]  ? __pfx_pci_pm_runtime_resume+0x10/0x10
[  287.381390]  rpm_resume+0x529/0x6f0
[  287.381392]  ? lock_is_held_type+0x76/0x100
[  287.381394]  __pm_runtime_resume+0x68/0x90
[  287.381396]  vfio_pci_core_enable+0x44/0x310
[  287.381398]  vfio_pci_open_device+0x1c/0x80
[  287.381399]  vfio_df_open+0x10f/0x150
[  287.381401]  vfio_group_fops_unl_ioctl+0x4a4/0x7b0
[  287.381402]  __se_sys_ioctl+0x71/0xc0
[  287.381404]  do_syscall_64+0x14d/0x750
[  287.381405]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  287.381406]  ? trace_irq_disable+0x25/0xd0
[  287.381409]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  287.381410] RIP: 0033:0x447c8b
[  287.381413] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24
10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00
00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28
00 00
[  287.381414] RSP: 002b:00007ffff5fb2530 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[  287.381415] RAX: ffffffffffffffda RBX: 00007ffff5fb2d90 RCX: 0000000000447c8b
[  287.381416] RDX: 00007ffff5fb25b0 RSI: 0000000000003b6a RDI: 0000000000000006
[  287.381417] RBP: 00007ffff5fb2620 R08: 0000000000000000 R09: 00000000ffffffff
[  287.381418] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffff5fb2d78
[  287.381419] R13: 0000000000000016 R14: 00000000004f5440 R15: 0000000000000016
[  287.381423]  </TASK>

Initial analysis suggests it could be a false positive, depicting a
classic ABBA circular locking scenario:
* Trace#1 and Trace#2: Triggered while setting sriov_numvfs, where the
PF's vdev->memory_lock (A) is taken first, and then the VF's
dev_set->lock is allocated and taken (B).
* Trace#0: Triggered during VFIO_GROUP_GET_DEVICE_FD where first the
VF's dev_set->lock is taken (B) and then the PF's vdev->memory_lock
(A) is taken.

From Trace#1/Trace#2, the dev_set->lock (B) is allocated and
immediately grabbed during VF creation. Since it isn't taken until
after the device is fully created and VFIO_GROUP_GET_DEVICE_FD is
called on it, it's perfectly synchronized, and therefore cannot cause
a deadlock. As far as we know, this is at least true for the VFs being
created, i.e, we were able to find a 'dev_set' from the
'vfio_device_set_xa' xarray using 'idx' in vfio_assign_device_set().

I've tried this naiive diff, which seems to help with the issue, but
may not be a complete solution:

--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -106,7 +107,8 @@ int vfio_assign_device_set(struct vfio_device
*device, void *set_id)
 found_get_ref:
        dev_set->device_count++;
        xa_unlock(&vfio_device_set_xa);
-       mutex_lock(&dev_set->lock);
+       mutex_lock_nested(&dev_set->lock, SINGLE_DEPTH_NESTING);
        device->dev_set = dev_set;
        list_add_tail(&device->dev_set_list, &dev_set->device_list);
        mutex_unlock(&dev_set->lock);

I wanted your opinion or suggestions on how to proceed with the warning.

Thank you.
Raghavendra

[1]: https://lore.kernel.org/all/20260303193822.2526335-1-rananta@google.com/
