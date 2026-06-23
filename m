Received: from www3579.sakura.ne.jp (www3579.sakura.ne.jp [49.212.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B2A2367D3
	for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 12:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.243.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782219364; cv=none; b=gU3whmeGORB7cExhzCJJo0TgMz1Qy7nxx6jCInsMF9B2MeEDY4zW2wes28yL1DATMWlDcRkUz4LKEgaxP0NDZlyKw5Gj6c6Dk/rJIyO5o4qfh2tTGM3nf0Lx+QTz1MKaSdAMNTECJFJRcrBOQZ+lTBe5DjCqUaiw5zJEd0sKSr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782219364; c=relaxed/simple;
	bh=NC4e5HkKbMXBmR/mNbiQBNrMVxlnVz9K0c54XWtXRaI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LcAd3WUlm44vWSdnATBJWPF1fYMVldKU4U96XPF3d8y8MtHxUIAHlKBSoTS9pbszfCMQBiy5ACZrog0RknwIZpQ6mt56fcGY/G0F2Zqs4Ookanugp09u+73tQhj1B81Z4xPNMeN+4uumcMKdi6Rzy5LrGP3DJkR3XBDUwaZbqBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp; dkim=fail (0-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b=dh2pX73k reason="key not found in DNS"; arc=none smtp.client-ip=49.212.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b="dh2pX73k"
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
	(authenticated bits=0)
	by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 65NC5MDm068220
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 23 Jun 2026 21:05:22 +0900 (JST)
	(envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=9icVwESoPEziromrElTWXlq4W6A+7nPEVg5wxcfPes8=;
        c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20250326; t=1782216322; v=1;
        b=dh2pX73k57bNitgcjzM+naWKr7Mn+CiVA2w1u0Eyi8E3uZ4EkBqjyV40LcPMs3Zp
         G421yHXRFJPMer6h4x+VabcMYOMMW+1McFGt/MCo3BPGdrbACThjlQiLjZNdonH8
         ouHUg4L1dxNiG313ZrDgoriFiRE5JRl5oEYwDa2HoWKshSSroog9NJdU718MtGs6
         1bt+TFiSfpROxOzvm3dINrwBxFjb6G9UHSwk6EHWhWz/M1X4/ikS3lUN04byv7Xq
         Ou9E3yeBLCmjMPq8oEP5s/YkC7F1XZeJ1VTQZE502qMwptrnf/BWvWz+yWLC1VkQ
         Qm15dwUnyeh62sFEHa5ooQ==
Message-ID: <b8154a3d-5538-42e1-995b-2aeb05daa4ab@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 23 Jun 2026 21:05:22 +0900
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] migration/ram: Abort on unsupported migratable RAM
 changes
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
        Hanna Reitz <hreitz@redhat.com>,
        =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>,
        Zhao Liu <zhao1.liu@intel.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Anthony PERARD <anthony@xenproject.org>,
        "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
        Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
        Reinoud Zandijk <reinoud@netbsd.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Alex Williamson <alex@shazbot.org>,
        =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>,
        qemu-block@nongnu.org, xen-devel@lists.xenproject.org,
        kvm@vger.kernel.org
References: <20260611-ram-v1-0-a2dacf699718@rsg.ci.i.u-tokyo.ac.jp>
 <ajmZrT1d0QXCWTNq@x1.local>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <ajmZrT1d0QXCWTNq@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026/06/23 5:23, Peter Xu wrote:
> On Thu, Jun 11, 2026 at 03:35:47PM +0900, Akihiko Odaki wrote:
>> Supersedes: <20260604-migration-v1-1-cef4a5b1bbdd@rsg.ci.i.u-tokyo.ac.jp>
>> ("[PATCH] system/physmem: Assert migration invariants")
>>
>> ram_mig_ram_block_resized() already aborts migration when migratable RAM
>> is resized. Extend the same handling to other unsupported changes to the
>> migratable RAMBlock set, such as removing a migratable RAMBlock or
>> changing a RAMBlock's migratable state.
>>
>> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>> ---
>> Akihiko Odaki (3):
>>        system/physmem: Pass RAMBlock to RAMBlockNotifier callbacks
>>        system/physmem: Notify RAMBlock migratable and idstr changes
>>        migration/ram: Abort on unsupported migratable RAM changes
> 
> Thanks for looking at this, Akihiko.
> 
> I understand this is a protection to the system to trap error use cases.
> The question I have is do we have any possible way to trigger these.
> 
> I worry we add a bunch of code and notifiers, and then there's zero way to
> trigger, essentially add dead code.
> 
> Logically we could already add assert() on things we don't expect to
> happen.  This case might be slightly risky, but still I think we can also
> consider things like error_report_once() instead of introducing slightly
> complex notifiers just to cover what we think shouldn't happen.
> 
> Or do you have way to trigger any of these notifiers?

I simply followed what's already done for resize(), expecting resize() 
does the correct thing and following it won't introduce a regression.

> 
> PS: today I went back and I wanted to try how the existing resize()
> notifier would trigger, I can't even reproduce it with David's example
> here:
> 
> https://lore.kernel.org/qemu-devel/20210429112708.12291-1-david@redhat.com/#t
> 
> I can trap a qemu_ram_resize(), but that's invoked with newsize==rb->size,
> so it didn't really notify a thing.  I don't really know how to trigger
> ram_block_notify_resize().  If you know, please share.
I made an LLM amend the reproducer. Below is its output.

Regards,
Akihiko Odaki

LLM output:

A synthetic but effective variant is to add custom ACPI filler tables so 
the initial `etc/acpi/tables` blob is just under the 128 KiB alignment 
bucket, then let the normal boot-time fw_cfg ACPI rebuild push it over.

I tested this shape:

```sh
truncate -s 65000 /tmp/fill1
truncate -s 50600 /tmp/fill2
```

Then add to the original-ish command:

```sh
-device pcie-root-port,id=rp0,chassis=1,slot=1 \
-acpitable sig=FI1A,data=/tmp/fill1 \
-acpitable sig=FI2A,data=/tmp/fill2
```

Observed via `info ramblock`:

```text
before cont:
/rom@etc/acpi/tables   Used 0x0000000000020000

after cont:
/rom@etc/acpi/tables   Used 0x0000000000040000
```

So this does produce a real RAMBlock used-size growth during boot in the 
current tree. With migration started before `cont` using a stalled 
`exec:` target, `info migrate` moved to `cancelling`, which is 
consistent with the current resize-during-precopy abort path.

The key is not the root port itself; the key is making the ACPI table 
rebuild cross `ACPI_BUILD_TABLE_SIZE` alignment. The filler is a bit 
artificial, but it is a good stress variant for the exact class of bug.
