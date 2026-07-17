Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF335346AC2
	for <kvm@vger.kernel.org>; Fri, 17 Jul 2026 03:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784257387; cv=none; b=dCIgPgtm8p3CJJFGTMtlzFqpQNEwBQK0pvoPSAAoHipZV4FnEmlzIWgM8q6oxj5t6IQPvlm8dnuIeUND8VyAfSWmq/45SC+YkA9m1r5BlWctHJ91D/v6+nJhkX48dTDX7vkViuYB65xDvv0bLpC1H8w57/QaISNcIF3O1/86as0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784257387; c=relaxed/simple;
	bh=2TPMC3FYIpUUyV4GdEwume2pSg1gr54r8oZ4rqSamTQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S/ZAeJRVOmfqm091DkhAiWPlYfXbkesxAAgM6DsOqeKSWzjYKXJeYiE2eQInT4ReNtK0RXOUKUfi0PKs1LE3XR/oRv3HrzjFuZPqicCXgzwGfILDoA7VcOEx3/Sjc68ETP+FKagBQwpoxa/uz/7G/tPsv9T+H7/2RRh+GF6wBm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ANtcWZ6M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ANtcWZ6M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D4451F000E9;
	Fri, 17 Jul 2026 03:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784257385;
	bh=45+GD85+b/4eKivYAecd1CxXUHL5V79+3qNmlg+ViWA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ANtcWZ6M4Ae5L9Y9s4T7cw/tckU8N9IUFC/1CWI5nGfPrTgv7TbEEbYGc8KxOncTx
	 C1n6Xt2WoTAj/KfvQguRAu+T6th70sqKhsYGZFvbcqMq8F0mah4jkaV7beB0yHpnf3
	 3zlDzLV0own1i8LnNZ4VKcr3obzXmG9vuZuOG2OGFz8fcTesvj4fw2kpIlT9AievNF
	 4ums6a3qZTLhp6UY2hBcgKgHI64fxrtuj1KqTsshQQ95zUZhZa7+XstfCG0pMcNQTG
	 WcBA/+TbSMn6QgRmOWhwfRkpt+9pBte0Noqq4MAXKSiO32Gs3MRE1AZ8BnhgQhJZJo
	 FhNtlKyW7J3Lg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] vhost-vdpa: reject zero-size unmap
Reply-To: sashiko-reviews@lists.linux.dev
To: "Weimin Xiong" <xiongwm2026@163.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260716030238.124368-1-xiongwm2026@163.com>
References: <20260716030238.124368-1-xiongwm2026@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 03:03:04 +0000
Message-Id: <20260717030305.3D4451F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Pinned page leak in vhost_vdpa_pa_map() error paths due to incorre=
ct nchunks reset.
- [High] Missing vma->vm_start boundary check in vhost_vdpa_va_map() causes=
 integer underflow for map offset calculation.
- [Medium] The core vhost ioctl handler for VHOST_IOTLB_INVALIDATE does not=
 reject zero-size requests, leading to integer underflow.
- [Medium] vhost_vdpa_va_map silently skips VMAs that do not meet its backi=
ng criteria instead of returning an error, leaving holes in the mapping.
--

--- Patch [1]: [PATCH] vhost-vdpa: reject zero-size unmap ---
commit d3e42a0021551a09934ef567e35c3c64cdff596d
Author: xiongweimin <xiongweimin@kylinos.cn>
Subject: vhost-vdpa: reject zero-size unmap

This patch rejects unmap requests with a size of zero in vhost_vdpa_unmap.
This prevents an integer underflow that would cause the entire IOTLB range
to be incorrectly unmapped.

> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index ac55275fa0d0a..f1724bfdc46fb 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -1032,6 +1032,9 @@ static void vhost_vdpa_unmap(struct vhost_vdpa *v,
>  	const struct vdpa_config_ops *ops =3D vdpa->config;
>  	u32 asid =3D iotlb_to_asid(iotlb);
> =20
> +	if (!size)
> +		return;
> +
>  	vhost_vdpa_iotlb_unmap(v, iotlb, iova, iova + size - 1, asid);

[Severity: Medium]
This isn't a bug introduced by this patch, but while reviewing this=20
zero-size fix, I noticed a similar pattern in the core vhost module.

Does vhost_process_iotlb_msg() suffer from the exact same flaw for
VHOST_IOTLB_INVALIDATE?

drivers/vhost/vhost.c:vhost_process_iotlb_msg()
    case VHOST_IOTLB_INVALIDATE:
        if (!dev->iotlb) {
            ret =3D -EFAULT;
            break;
        }
        vhost_vq_meta_reset(dev);
        vhost_iotlb_del_range(dev->iotlb, msg->iova,
                      msg->iova + msg->size - 1);
        break;

If userspace sends VHOST_IOTLB_INVALIDATE with size =3D=3D 0, would this
similarly underflow and wipe out the entire IOTLB tree?

>  	if (ops->set_map) {
>  		if (!v->in_batch)
>  			ops->set_map(vdpa, asid, iotlb);

[Severity: High]
This is a pre-existing issue, but looking at the error rollback path in=20
vhost_vdpa_va_map() mentioned in the commit message, is there a missing=20
boundary check on vm_start?

drivers/vhost/vdpa.c:vhost_vdpa_va_map()
    vma =3D find_vma(dev->mm, uaddr);
    if (!vma) {
        ret =3D -EINVAL;
        break;
    }
    map_size =3D min(size, vma->vm_end - uaddr);

find_vma() returns the first VMA where vm_end > uaddr, which doesn't=20
guarantee that vm_start <=3D uaddr. If uaddr falls in an unmapped hole=20
before the VMA, what happens to the offset calculation later in the=20
function?

drivers/vhost/vdpa.c:vhost_vdpa_va_map()
    offset =3D (vma->vm_pgoff << PAGE_SHIFT) + uaddr - vma->vm_start;
    map_file->offset =3D offset;

Could subtracting vm_start from uaddr result in an integer underflow=20
and produce an incorrect offset when uaddr < vm_start?


[Severity: Medium]
This is another pre-existing issue in the same function. Could=20
vhost_vdpa_va_map() be silently dropping unsupported VMAs without=20
returning an error?

drivers/vhost/vdpa.c:vhost_vdpa_va_map()
    if (!(vma->vm_file && (vma->vm_flags & VM_SHARED) &&
        !(vma->vm_flags & (VM_IO | VM_PFNMAP))))
        goto next;

When a VMA doesn't meet the backing criteria, the code skips the mapping=20
logic and advances the pointers:

drivers/vhost/vdpa.c:vhost_vdpa_va_map()
next:
    size -=3D map_size;
    uaddr +=3D map_size;
    map_iova +=3D map_size;

Because the size decreases and the loop continues, the function can=20
eventually return 0 (success). Will this give userspace a false guarantee=20
that the entire requested IOVA range was mapped, leading to unexpected=20
faults during DMA?


[Severity: High]
This is also a pre-existing issue, but I noticed a potential resource=20
leak in the error paths for vhost_vdpa_pa_map().

When a discontiguous page triggers a successful map, nchunks is reset to=20
0 and a new pending chunk begins at this_pfn:

drivers/vhost/vdpa.c:vhost_vdpa_pa_map()
            map_pfn =3D this_pfn;
            iova +=3D csize;
            nchunks =3D 0;
        }

If there are remaining pages in the current batch, they are added to the=20
pending chunk. If the next batch fails to pin, the code jumps to out.=20
Because nchunks is only incremented after a successful pin, it remains 0:

drivers/vhost/vdpa.c:vhost_vdpa_pa_map()
out:
    if (ret) {
        if (nchunks) {
            unsigned long pfn;

            /*
             * Unpin the outstanding pages ...
             */
            WARN_ON(!last_pfn);
            for (pfn =3D map_pfn; pfn <=3D last_pfn; pfn++)
                unpin_user_page(pfn_to_page(pfn));

Since the if (nchunks) check evaluates to false, does this bypass the=20
unpin loop entirely and permanently leak the pages in the pending chunk?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716030238.1243=
68-1-xiongwm2026@163.com?part=3D1
