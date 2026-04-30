Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A94F3E639B;
	Thu, 30 Apr 2026 12:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777550911; cv=none; b=PUalKMmHv+Us01L49uRkiv01spD/AwhIbOZCuYiVM2FO6LTtE238qzo/fAY3oeBufsFlohpkzShX52pmMgYWA4TxSDp1KHI0yZyik/0blgw/LpyDwuERe24WXEdYZ04eXULDEJakUyQP47FT79eDAwsbIq/ctj0xjMSkRwGfgpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777550911; c=relaxed/simple;
	bh=oluNaMfMjMlDnbEbvhyZlQVRhDvgPAxeU1QvDeTib+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kcm9NPBnuhJKuN2WIGCnjn/XJBN7GX7EPVvC+rW6ov2mhPhXvofcS4kEZBYIpRfnID3oIhpCCB4N15oel7iBQppH9sFNxRS66b3Zn7D3faDYaV7SqCIPfepAdvn+3/WuFtrbE6pL1fRwLdj+Yi8i8yAoyaxo1yRhH1X1ddG7Knw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 10C5987606;
	Thu, 30 Apr 2026 14:08:26 +0200 (CEST)
Message-ID: <1a7c35d8-d7fe-4eec-ad83-da92780b62ce@proxmox.com>
Date: Thu, 30 Apr 2026 14:08:25 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/28] KVM: combined patchset for MBEC/GMET support
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, jon@nutanix.com
References: <20260428110946.11466-1-pbonzini@redhat.com>
 <dbc9f517-bd57-4c1c-a638-c33bb83a1171@proxmox.com>
 <CABgObfaFeK4kJpMGuki2hQxnz2ij8Nyyk0egxEfW4b_OYf9hgg@mail.gmail.com>
Content-Language: en-US
From: David Riley <d.riley@proxmox.com>
In-Reply-To: <CABgObfaFeK4kJpMGuki2hQxnz2ij8Nyyk0egxEfW4b_OYf9hgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1777550806435

On 4/30/26 12:27 PM, Paolo Bonzini wrote:
> On Wed, Apr 29, 2026 at 3:05 PM David Riley <d.riley@proxmox.com> wrote:
>> I observed the following:
>> The guest now never actually boots into Windows. It gets stuck before
>> that and therefore does not even enter Windows Recovery.
> Last minute rebase screwup. The old code had:
>
>      vmcb02->control.misc_ctl = vmcb01->control.misc_ctl & SVM_MISC_ENABLE_NP;
>
> New code has:
>
>      vmcb02->control.misc_ctl = vmcb01->control.misc_ctl & SVM_MISC_ENABLE_NP;
>
> And now needs to pass down GMET as well.

Thanks for looking into it.
I changed the line to:

vmcb02->control.misc_ctl = vmcb01->control.misc_ctl & (SVM_MISC_ENABLE_NP | SVM_MISC_ENABLE_GMET);

and was able to start the Windows VM with VBS enabled.

> Paolo
>
>

