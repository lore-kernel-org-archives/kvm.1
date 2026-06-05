Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DECE26B2D2
	for <kvm@vger.kernel.org>; Fri,  5 Jun 2026 13:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780667166; cv=none; b=WtOgKoQ/KcsagDU+Lg6mFc9hons07+5vtqi1OZQgatS7/89aurz1gQXb3AWaLch+Ey5KfVw6y8f3E/vSO2Wsjj7o4rZg9QG2OeZ7rZaiwmi+DV01osYOQ23vkXu6RL0cC+H93ZSrW1C25FPc7usPHQ6/Hb1NnF6RukfSJWDcjuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780667166; c=relaxed/simple;
	bh=UtGNnPDApxMgm3JPEGgbuZe8mNB4Pc8pAiEu55aeJ5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ba0Y1gKZrW9T4RRng/NTiSHZPbohaZXE7AqXjSGvIP73ZjZ91H3iWod8tyigeXQbbVpTpYYORcxOmX8uBR1hjjjuhSXEb3gi2+jVeHzYCpRFzhfir88wKou/PFHgvy9WHVAhisRwQ7uv4r1aobovE+2XJCVSfwPdZqCp4fB+bjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=gscinGhe; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="gscinGhe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=yld494QWOsUHEiHXxwJqnUvG/nKQkrdisZtXex83j+g=; b=gscinGheDUiVVSDV
	SPywv7RayzH5tj70NydC6I4MmOTodUA3Yqz/EacZHuo4Xv/qQooNfo/hS5226Z817bLJZtZsPnMQb
	zcqIL9Jn0TlOeoBpaOg9JyM5a3bSLAN1tU5Al/v4Dv9n9tuVDapj775MbcBo8V1bIfa+dA/VJVG9a
	bGd/ljh252GYtgzUCg6Squ6Nkz69P9LJvZO3C+IkiXpkUq/I4rYr9fiG9cJTWB120KK5PdKpw318F
	9AxPiUkisj9Vqts7OUHKDyESTDBVsxRMF5ocIxjbLHrFbqYVqmwuWLZXvm+JXYbThX650jMizjY0i
	WLtXfEtUJFumiRNIxA==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
	(envelope-from <dg@treblig.org>)
	id 1wVUar-00000005SjV-0UQq;
	Fri, 05 Jun 2026 13:28:13 +0000
Date: Fri, 5 Jun 2026 13:28:13 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Zhenzhong Duan <zhenzhong.duan@intel.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	David Hildenbrand <david@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@mailo.com>,
	qemu-rust@nongnu.org, Alex Williamson <alex@shazbot.org>,
	=?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
	"Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
	Fabiano Rosas <farosas@suse.de>, Mark Kanda <mark.kanda@oracle.com>,
	Ben Chaney <bchaney@akamai.com>,
	Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
	Zhao Liu <zhao1.liu@intel.com>, Eric Blake <eblake@redhat.com>,
	Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v5 12/12] RFC: monitor: add 'info ramblock-attributes'
 command
Message-ID: <aiLO7ZQvowWHwK63@gallifrey>
References: <20260604-rdm5-v5-0-5768e6a0943d@redhat.com>
 <20260604-rdm5-v5-12-5768e6a0943d@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260604-rdm5-v5-12-5768e6a0943d@redhat.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.88+deb13-amd64 (x86_64)
X-Uptime: 13:27:04 up 20 days, 16:39,  2 users,  load average: 0.06, 0.04,
 0.00
User-Agent: Mutt/2.2.13 (2024-03-09)

* Marc-André Lureau (marcandre.lureau@redhat.com) wrote:
> Add a new 'info ramblock-attributes' HMP command and the corresponding
> 'x-query-ramblock-attributes' QMP command to display the shared/private
> memory attributes for ram blocks.
> 
> The QMP command returns structured data (RamBlockAttributesInfo list
> with per-range shared/populated attributes), while HMP formats it for
> human consumption.
> 
> This is useful for debugging confidential guests (TDX, SNP) to inspect
> which memory regions are shared vs private, and their population state
> when a RamDiscardManager is present (e.g. virtio-mem).
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  qapi/machine.json             | 56 ++++++++++++++++++++++++++++++++++
>  include/monitor/hmp.h         |  1 +
>  hw/core/machine-hmp-cmds.c    | 32 +++++++++++++++++++
>  system/ram-block-attributes.c | 71 +++++++++++++++++++++++++++++++++++++++++++
>  hmp-commands-info.hx          | 13 ++++++++
>  5 files changed, 173 insertions(+)
> 

<snip>

For HMP,

Acked-by: Dr. David Alan Gilbert <dave@treblig.org>

however, you might consider whether it would be better to add it
to the existing "info ramblock"

Dave

> +void hmp_info_ramblock_attributes(Monitor *mon, const QDict *qdict)
> +{
> +    Error *err = NULL;
> +    g_autoptr(RamBlockAttributesInfoList) list = NULL;
> +    RamBlockAttributesInfoList *it;
> +
> +    list = qmp_x_query_ramblock_attributes(&err);
> +    if (hmp_handle_error(mon, err)) {
> +        return;
> +    }
> +
> +    for (it = list; it; it = it->next) {
> +        RamBlockAttributesInfo *rba = it->value;
> +        RamBlockAttributeRangeList *r;
> +
> +        monitor_printf(mon, "%s:\n", rba->name);
> +        for (r = rba->ranges; r; r = r->next) {
> +            RamBlockAttributeRange *range = r->value;
> +            const char *shared = range->shared ? "shared" : "private";
> +            const char *pop = range->has_populated ?
> +                (range->populated ? "+populated" : "-populated") : "";
> +
> +            monitor_printf(mon,
> +                           "  0x%016" PRIx64 "-0x%016" PRIx64 " %s%s\n",
> +                           range->start,
> +                           range->start + range->length - 1,
> +                           shared, pop);
> +        }
> +    }
> +}
> diff --git a/system/ram-block-attributes.c b/system/ram-block-attributes.c
> index 59ec7a28eb0..fb657ffca35 100644
> --- a/system/ram-block-attributes.c
> +++ b/system/ram-block-attributes.c
> @@ -11,6 +11,7 @@
>  
>  #include "qemu/osdep.h"
>  #include "qemu/error-report.h"
> +#include "qapi/qapi-commands-machine.h"
>  #include "system/ramblock.h"
>  #include "trace.h"
>  
> @@ -221,3 +222,73 @@ static void ram_block_attributes_class_init(ObjectClass *klass,
>      rdsc->get_min_granularity = ram_block_attributes_rds_get_min_granularity;
>      rdsc->is_populated = ram_block_attributes_rds_is_populated;
>  }
> +
> +RamBlockAttributesInfoList *qmp_x_query_ramblock_attributes(Error **errp)
> +{
> +    RamBlockAttributesInfoList *head = NULL, **tail = &head;
> +    RAMBlock *block;
> +    size_t rba_block_size = ram_block_attributes_get_block_size();
> +
> +    RCU_READ_LOCK_GUARD();
> +
> +    RAMBLOCK_FOREACH(block) {
> +        RamBlockAttributesInfo *rba;
> +        RamBlockAttributeRangeList **range_tail;
> +        RamBlockAttributes *attr = block->attributes;
> +        RamDiscardManager *rdm;
> +        unsigned long pos;
> +
> +        if (!attr) {
> +            continue;
> +        }
> +
> +        rdm = memory_region_get_ram_discard_manager(block->mr);
> +        g_assert(rdm);
> +
> +        rba = g_new0(RamBlockAttributesInfo, 1);
> +        rba->name = g_strdup(block->idstr);
> +        range_tail = &rba->ranges;
> +
> +        pos = 0;
> +        while (pos < attr->bitmap_size) {
> +            bool is_shared = test_bit(pos, attr->bitmap);
> +            unsigned long next;
> +            uint64_t start_offset, length;
> +            RamBlockAttributeRange *range;
> +
> +            if (is_shared) {
> +                next = find_next_zero_bit(attr->bitmap,
> +                                          attr->bitmap_size, pos);
> +            } else {
> +                next = find_next_bit(attr->bitmap,
> +                                     attr->bitmap_size, pos);
> +            }
> +
> +            start_offset = (uint64_t)pos * rba_block_size;
> +            length = (uint64_t)(next - pos) * rba_block_size;
> +
> +            range = g_new0(RamBlockAttributeRange, 1);
> +            range->start = start_offset;
> +            range->length = length;
> +            range->shared = is_shared;
> +
> +            {
> +                MemoryRegionSection section = {
> +                    .mr = block->mr,
> +                    .offset_within_region = start_offset,
> +                    .size = int128_make64(length),
> +                };
> +                range->has_populated = true;
> +                range->populated =
> +                    ram_discard_manager_is_populated(rdm, &section);
> +            }
> +
> +            QAPI_LIST_APPEND(range_tail, range);
> +            pos = next;
> +        }
> +
> +        QAPI_LIST_APPEND(tail, rba);
> +    }
> +
> +    return head;
> +}
> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> index 82134eb6c21..f119b9cfebc 100644
> --- a/hmp-commands-info.hx
> +++ b/hmp-commands-info.hx
> @@ -761,6 +761,19 @@ SRST
>      Dump all the ramblocks of the system.
>  ERST
>  
> +    {
> +        .name       = "ramblock-attributes",
> +        .args_type  = "",
> +        .params     = "",
> +        .help       = "Display ramblock shared/private attributes",
> +        .cmd        = hmp_info_ramblock_attributes,
> +    },
> +
> +SRST
> +  ``info ramblock-attributes``
> +    Display the shared/private memory attributes for ram blocks.
> +ERST
> +
>      {
>          .name       = "hotpluggable-cpus",
>          .args_type  = "",
> 
> -- 
> 2.54.0
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
