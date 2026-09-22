Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778813BB106
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 20:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790108952; cv=pass; b=iiokZ8g+a5Jne7oJRfZNRuhsHup6y8S9L+wMBgZBsZO0UPHMf5o8ho13JTLa02AwuSaXT4JgtFSSo5MEuUPV2zGXmGkvleRiKli65XCqLCQTmDTTS9nRbDW1an69ndGiypFQHm/p8CK1MNq6r2+lH3fBm22q3iQipEeFjVaC7/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790108952; c=relaxed/simple;
	bh=nl0WayBfnBzXB16tsQQ8C7lVQDuEYmE5cOfzxnYFlOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r6/sF91yo9uJ4cVsr7TuqX6zYy8rekTiWKpx5079+PYx6WU/JuYBUxmZoXv/4TNQe3aV4WqckLaX/Kwn5ALf/krQnmb2SZibUl73ytf6x+YmVWYy94Rj97JAhSAsEkUlseCufCqE+ydnJ6qmaUnBlgsawm4T6cypZCaVyXs4Da8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xz3lNUej; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xz3lNUej"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6a5f95a879cso825a12.0
        for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 13:29:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790108944; cv=none;
        d=google.com; s=arc-20260327;
        b=mHPkuHnOoEHmllkuAW9zFvuPV8DTEfxJTVbh05MbHC/GFPgU3bP9Zyk5j9T9BSz4gt
         9HPu66PrGOlmSc0KSc2hN0dcq6dPWE9pxiZhbJIsC2N7AKqr6k2K28dx1ViSeNuYlhPx
         RHmGHe/iRe+O7AQ0hOVoJakw9vZbDxhCqfQS9gguhq2wMFUInpCCty+AW4SRkFXcOnjz
         Gc0G1t6epqybexhFsioaSbvW/rHeFFxhBqLBuK4C0WN5jda9PPj7vsXUIRbnWzJFz77I
         uJ5V0YFSW6hm09UVqfyJ9t5uLoXqR1nG0Tqhd7m1bJ9h6ladJ00MaZxx/RV83UxAiZBL
         wXFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f4auqSnGVaI9/viQvIpi/oQzDocBQYdGMjQ8F0EupbI=;
        fh=pe6ISAP47YXNcB8kiQTukPsIMKbQ3wCFWZL9+9pgaHM=;
        b=QgVY+mNA/oPSjn2XCfEUu3rtIJspok2xC2GNILu5h1LeerdMj3Pgym5/mlDVVNA04/
         Z1OSHyE7R0g9+VoZxWG3SATOtyMzfrkNSRAj/zXGnMRvtT4gEwYnW461yvaM9DHw01jH
         4Uq2pEstf6AjvGSJjT8M2YURCSaq2/qFL+1ok07Gf2xr3otEXRbWK+7UUkKNpa6NXkQk
         t18ybYkFBpztdNSDUb+48cmY5ztrQSuup9+HXEFnEtgJU80t4l/95U0zwU/wXScXE3pR
         CMYjkNr5np4MAzY+hQI3D+aKkGpEcEJsU8UbmsRo0kua3AXm5civXFmnt2Npiz6V+LUN
         8m/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790108944; x=1790713744; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f4auqSnGVaI9/viQvIpi/oQzDocBQYdGMjQ8F0EupbI=;
        b=Xz3lNUej9X8VdZDr8tqKR2RBNQ8sjqxUZeWOZhQTAps9hA468+vYGp4qrb25FFAgX4
         GevH59xtPZy8XUwYStm65+wcB+kG49zfUUEUo+d3/JJR4FVrf+3C8JVYJhDoEaRGYUH6
         vyVI/Xd7elY9LlGnqji6588OhLgxDmxyED9rmSyF3zE12+KK9NXmpMMCieDzFmjIizff
         os3tQbObDZ3wudFkxlG5LRwlRvyAYs8llnK+Ue/v9Ga9Bcb4qmWOaCtCbMwL5rrtThct
         /mW5PCz2BAR6oBnCULgKWtTgMIUZgfv3voYk/U3Sktb+sMGey3rpCnRMFZngdV4gB/ZJ
         QoBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790108944; x=1790713744;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f4auqSnGVaI9/viQvIpi/oQzDocBQYdGMjQ8F0EupbI=;
        b=eyygReTohhKx3fb24oI35kOhHKrC0BCw+SPMGOUoL54U4Qa1eLd+K38alLbEYpavNr
         0swkCEZaA4Rk19Le6PF6WvQcvAWNtvyzkz91u/+RT9MyAW6KqZESq6BW+Ur6PQjWncRG
         ak/hEMFy92EvEr8NY2+j8af60xjBIrZ9RfRKMfsWEH9LOtd4Jn5gHAvTIwE/Iq/11NFA
         NgP2iYeOn62smB1NG0b/dfAaFq+qpvt5tOaIEqEjmPa3qwxFdYlrCydKmYwWDuiO6QzR
         O5ncZVbDcbDZ0359xq4YO0tzYNY+uptuqs4zrlPlf02UT66slInhMCdd5ae/NoTGjpYR
         5XFQ==
X-Forwarded-Encrypted: i=1; AKwUvBycndtf4MW2IJb0WTEWTKPQZaZY+tagBmuHyIB6MbpSQeDvhj8oJhDT7v+sVd9OBhbjJl4=@vger.kernel.org
X-Gm-Message-State: AFuF++lCqvA41XQHsz1kqMG7qvlr4eL1rsE5OvcjeeJRBISu05umxnKk
	UkP1lM3NEySQ7KDKinPGgZ1q2x3JETXWh9Fb3RBWViQUQcYW5RDYXyN4YdYP8I5yRs7igIUmYjP
	oY1c10cJFUPpddSfgZA4CGxqEcr0O4JopAfWIS98=
X-Gm-Gg: AYBFou0nKm7DwPkJ/aMMrlHkK/uQ++tCPLtKHlnDt3Dj2twFZj6gmBxVebTGzfVlgyK
	W5RHknFqsNuh/Zq5a8do3wsWrj/GUqiN0rVA4u0jRJDtL0jElAntq8IpO+/9+u2k7dYzzTkE8Gh
	1L97oDqiPxwaHPa4IoWqyiWGYk1IhkjniQG2QcY2JpXnsQOLUuElKxOWQvvQ2OfHIFmoF+3HOHp
	pRkiLVn/k36XtiLuax4rWSlWbOlMK/QMMwxtZqHordy1HCEi5yiiUDvCQNwbXrSWopI9w6ZRfZL
	yDDuPzgFpIwmwpCwhmTsufjJJ0rn5ScCMxns5khYYGY5hNGqG5ai7Q4W/NdklRkLdu3OyE1T+eG
	u18FTy1Kh
X-Received: by 2002:a05:6402:683:b0:6aa:128c:36ad with SMTP id
 4fb4d7f45d1cf-6aab3b997d0mr10064a12.10.1790108943216; Tue, 22 Sep 2026
 13:29:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910-snp-invalid-input-v1-1-fb2e03da614b@google.com>
 <0b2d8858-b361-4a64-986a-4c179210fbec@amd.com> <aqlWt4jb4CSPnecN@google.com>
 <d6179d34-a4b0-4548-8298-b790b333d22f@amd.com> <CAJxe5ctcVxmhRSw3Gt0POQTzRKoxXo7+Y3CPDe7cUZvC0QPK+g@mail.gmail.com>
 <aqrhFvwFJsQTaEkz@google.com> <CAJxe5csCb0DHZmJo9a-asXZ-tYdcyK1y0Y4Y9Uoixqn=sa8zRQ@mail.gmail.com>
 <arF9CXWC_UDYUMmf@google.com>
In-Reply-To: <arF9CXWC_UDYUMmf@google.com>
From: Jacky Li <jackyli@google.com>
Date: Tue, 22 Sep 2026 13:28:51 -0700
X-Gm-Features: AclHuK_mY43f-bAoEDGwDRGxsfpJ91_apKdGyjoPSuWVw4gI8ssd82nL_grfFCw
Message-ID: <CAJxe5csuNRcULSTeRRAq0GGQASTTpgwqOCXwNZJtApeZb_Va3A@mail.gmail.com>
Subject: Re: [PATCH] KVM: SEV: Return INVALID_INPUT on SNP req/resp buffer
 access failure
To: Sean Christopherson <seanjc@google.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>, 
	Ashish Kalra <ashish.kalra@amd.com>, Jacob Xu <jacobhxu@google.com>, 
	Supraja Sridhara <suprajasri@google.com>, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 11:53=E2=80=AFAM Sean Christopherson <seanjc@google=
.com> wrote:
>
> No, kvm_vcpu_map() actually has far worse semantics.  GUP pins the *page*=
, it does
> not pin the userspace mapping.  I.e. kvm_vcpu_map() guarantees that KVM w=
on't write
> to a freed page, but that's literally it.  E.g. if userspace mprotect()'s=
 the page
> to make it read-only, KVM will write to what is supposed to be a RO page.=
  Or if
> userspace completely unmaps the page, KVM will write to soon-to-be-freed =
memory.

Sorry for the confusion. I didn't mean writing to the response page through
map.hva; I only meant calling kvm_vcpu_map() to validate and pin the page,
while still using kvm_write_guest() to copy the response back:

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -4231,19 +4231,25 @@ static int snp_handle_guest_req(struct
vcpu_svm *svm, gpa_t req_gpa, gpa_t resp_
  if (kvm_read_guest(kvm, req_gpa, sev->guest_req_buf, PAGE_SIZE))
  return -EIO;

+ CLASS(kvm_vcpu_map_local, map)(&svm->vcpu, gpa_to_gfn(resp_gpa));
+ if (map.ret) {
+ svm_vmgexit_bad_input(svm, GHCB_ERR_INVALID_INPUT);
+ return 1;
+ }
+
  data.gctx_paddr =3D __psp_pa(sev->snp_context);
  data.req_paddr =3D __psp_pa(sev->guest_req_buf);
  data.res_paddr =3D __psp_pa(sev->guest_resp_buf);

  /*
  * Firmware failures are propagated on to guest, but any other failure
  * condition along the way should be reported to userspace. E.g. if
  * the PSP is dead and commands are timing out.
  */
  ret =3D sev_issue_cmd(kvm, SEV_CMD_SNP_GUEST_REQUEST, &data, &fw_err);
  if (ret && !fw_err)
  return ret;

  if (kvm_write_guest(kvm, resp_gpa, sev->guest_resp_buf, PAGE_SIZE))
  return -EIO;

Because the actual payload write still goes through kvm_write_guest()
(uaccess) rather than map.hva, a concurrent mprotect(PROT_READ) or
munmap() would still cause kvm_write_guest() to fail rather than
overwriting a read-only page or soon-to-be-freed memory.

> Who cares?  The guest can only hurt itself by converting resp_gpa to priv=
ate.

The only reason we care from the hypervisor's perspective is that
a post-command -EIO/-EFAULT exit causes the VMM to abort and looks like
a hypervisor infrastructure failure rather than a guest error.

That said, this only matters if a malicious guest deliberately races a
conversion against its own request. Given the complexity of a gpc and
that kvm_vcpu_map() is being phased out, the 1-byte tickle write is much
simpler and good enough to protect normal guests from burning their
VMPCK or killing the VM over a bad resp_gpa.

I'll send a v2 with the tickle approach. Thanks!
